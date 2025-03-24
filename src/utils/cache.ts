interface CacheItem<T> {
  data: T;
  timestamp: number;
  expiresIn: number;
}

interface CacheConfig {
  expiresIn: number; // Duration in milliseconds
  key: string;
}

export class APICache {
  private static CACHE_PREFIX = 'dashboard_cache_';

  static async getOrFetch<T>(
    fetchFn: () => Promise<T>,
    config: CacheConfig
  ): Promise<T> {
    const cacheKey = this.CACHE_PREFIX + config.key;
    const cached = this.getFromCache<T>(cacheKey);

    if (cached) {
      return cached;
    }

    try {
      const data = await fetchFn();
      this.saveToCache(cacheKey, data, config.expiresIn);
      return data;
    } catch (error) {
      // If fetch fails and we have stale data, return it
      const staleData = this.getFromCache<T>(cacheKey, true);
      if (staleData) {
        console.warn(`Using stale data for ${config.key} due to fetch error`);
        return staleData;
      }
      throw error;
    }
  }

  private static getFromCache<T>(key: string, allowStale: boolean = false): T | null {
    try {
      const item = localStorage.getItem(key);
      if (!item) return null;

      const cached = JSON.parse(item) as CacheItem<T>;
      const now = Date.now();
      const isExpired = now - cached.timestamp > cached.expiresIn;

      if (isExpired && !allowStale) {
        localStorage.removeItem(key);
        return null;
      }

      return cached.data;
    } catch (error) {
      console.error('Cache read error:', error);
      return null;
    }
  }

  private static saveToCache<T>(key: string, data: T, expiresIn: number): void {
    try {
      const cacheItem: CacheItem<T> = {
        data,
        timestamp: Date.now(),
        expiresIn,
      };
      localStorage.setItem(key, JSON.stringify(cacheItem));
    } catch (error) {
      console.error('Cache write error:', error);
    }
  }

  static clearCache(key?: string): void {
    if (key) {
      localStorage.removeItem(this.CACHE_PREFIX + key);
    } else {
      Object.keys(localStorage)
        .filter(key => key.startsWith(this.CACHE_PREFIX))
        .forEach(key => localStorage.removeItem(key));
    }
  }

  static clearExpiredCache(): void {
    Object.keys(localStorage)
      .filter(key => key.startsWith(this.CACHE_PREFIX))
      .forEach(key => {
        try {
          const item = localStorage.getItem(key);
          if (!item) return;

          const cached = JSON.parse(item) as CacheItem<unknown>;
          const now = Date.now();
          if (now - cached.timestamp > cached.expiresIn) {
            localStorage.removeItem(key);
          }
        } catch (error) {
          console.error('Error clearing expired cache:', error);
        }
      });
  }
} 