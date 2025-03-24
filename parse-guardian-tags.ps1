Write-Host "Guardian API Tags by Category" -ForegroundColor Cyan
Write-Host "============================" -ForegroundColor Cyan
Write-Host ""

# Process tech tags if the file exists
if (Test-Path "guardian-tech-tags.json") {
    $techTagsJson = Get-Content -Raw -Path "guardian-tech-tags.json" | ConvertFrom-Json
    $techTags = $techTagsJson.response.results

    Write-Host "TECHNOLOGY TAGS" -ForegroundColor Green
    Write-Host "---------------" -ForegroundColor Green
    Write-Host ""

    foreach ($tag in $techTags) {
        $tagId = $tag.id
        $tagName = $tag.webTitle
        
        # Extract the last part of the ID for use in search terms
        $searchTermId = $tagId.Substring($tagId.LastIndexOf('/') + 1)
        
        Write-Host "$tagId" -ForegroundColor Yellow -NoNewline
        Write-Host " - $tagName"
        Write-Host "  Search term: '$searchTermId'" -ForegroundColor Gray
        Write-Host ""
    }

    Write-Host "Technology tags found: $($techTags.Count)" -ForegroundColor Cyan
    Write-Host ""
}

# Process general tags if the file exists
if (Test-Path "guardian-tags.json") {
    $tagsJson = Get-Content -Raw -Path "guardian-tags.json" | ConvertFrom-Json
    $tags = $tagsJson.response.results

    Write-Host "GENERAL TAGS (First 10)" -ForegroundColor Green
    Write-Host "-------------------" -ForegroundColor Green
    Write-Host ""

    # Display first 10 for brevity
    foreach ($tag in $tags | Select-Object -First 10) {
        $tagId = $tag.id
        $tagName = $tag.webTitle
        
        # Extract the last part of the ID for use in search terms
        $searchTermId = $tagId.Substring($tagId.LastIndexOf('/') + 1)
        
        Write-Host "$tagId" -ForegroundColor Yellow -NoNewline
        Write-Host " - $tagName"
        Write-Host "  Search term: '$searchTermId'" -ForegroundColor Gray
        Write-Host ""
    }

    Write-Host "Total general tags found: $($tags.Count)" -ForegroundColor Cyan
    Write-Host ""
}

Write-Host "USAGE INSTRUCTIONS:" -ForegroundColor Magenta
Write-Host "To use these tags in your SEARCH_TERMS object, use the 'Search term' value" -ForegroundColor White
Write-Host ""
Write-Host "Example in your code:" -ForegroundColor White
Write-Host "const SEARCH_TERMS = {" -ForegroundColor Yellow
Write-Host "  \"artificial-intelligence\": \"AND\",   // Must include AI content" -ForegroundColor Yellow
Write-Host "  \"apple\": \"OR\",                     // May include Apple content" -ForegroundColor Yellow
Write-Host "  \"facebook\": \"NOT\"                  // Must not include Facebook content" -ForegroundColor Yellow
Write-Host "};" -ForegroundColor Yellow 