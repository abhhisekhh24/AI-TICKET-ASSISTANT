# AI Ticket System - API Testing Script
Write-Host "============================================" -ForegroundColor Green
Write-Host "API ENDPOINT TESTING" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

$baseUrl = "http://localhost:3000/api"

function Test-Endpoint {
    param(
        [string]$url,
        [string]$method = "GET",
        [string]$description,
        [hashtable]$headers = @{},
        [string]$body = $null
    )
    
    Write-Host "`nTesting: $description" -ForegroundColor Cyan
    Write-Host "URL: $method $url" -ForegroundColor Gray
    
    try {
        if ($method -eq "POST" -and $body) {
            $response = Invoke-WebRequest -Uri $url -Method $method -Headers $headers -Body $body -ContentType "application/json" -TimeoutSec 10
        } else {
            $response = Invoke-WebRequest -Uri $url -Method $method -Headers $headers -TimeoutSec 10
        }
        
        Write-Host "✅ Status: $($response.StatusCode)" -ForegroundColor Green
        
        # Try to parse JSON response
        try {
            $jsonResponse = $response.Content | ConvertFrom-Json
            Write-Host "Response: $($jsonResponse | ConvertTo-Json -Depth 2 -Compress)" -ForegroundColor White
        } catch {
            Write-Host "Response: $($response.Content)" -ForegroundColor White
        }
        
    } catch {
        Write-Host "❌ Error: $($_.Exception.Message)" -ForegroundColor Red
        if ($_.Exception.Response) {
            Write-Host "Status: $($_.Exception.Response.StatusCode.value__)" -ForegroundColor Yellow
        }
    }
}

# Check if server is running
Write-Host "Checking if backend server is running..." -ForegroundColor Yellow

Test-Endpoint -url "$baseUrl/auth/users" -description "Get Users (should require auth)" -method "GET"

# Test signup endpoint
$signupData = @{
    name = "Test User"
    email = "test@example.com"
    password = "password123"
} | ConvertTo-Json

Test-Endpoint -url "$baseUrl/auth/signup" -description "User Signup" -method "POST" -body $signupData

# Test login endpoint  
$loginData = @{
    email = "test@example.com"
    password = "password123"
} | ConvertTo-Json

Test-Endpoint -url "$baseUrl/auth/login" -description "User Login" -method "POST" -body $loginData

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "MANUAL TESTING INSTRUCTIONS" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`n1. Make sure all servers are running:" -ForegroundColor Cyan
Write-Host "   - Backend: npm run dev (in ai-ticket-assistant/)" -ForegroundColor White
Write-Host "   - Inngest: npm run inngest-dev (in ai-ticket-assistant/)" -ForegroundColor White
Write-Host "   - Frontend: npm run dev (in ai-ticket-frontend/)" -ForegroundColor White

Write-Host "`n2. Test the application flow:" -ForegroundColor Cyan
Write-Host "   - Open http://localhost:5173" -ForegroundColor White
Write-Host "   - Try to signup/login" -ForegroundColor White
Write-Host "   - Create a test ticket" -ForegroundColor White
Write-Host "   - Check Inngest dashboard at http://localhost:8288" -ForegroundColor White

Write-Host "`n3. Common issues:" -ForegroundColor Cyan
Write-Host "   - CORS errors: Make sure backend is running first" -ForegroundColor White
Write-Host "   - MongoDB errors: Check MONGO_URI in .env" -ForegroundColor White
Write-Host "   - AI errors: Verify GEMINI_API_KEY is correct" -ForegroundColor White

Write-Host "`nTesting completed!" -ForegroundColor Green