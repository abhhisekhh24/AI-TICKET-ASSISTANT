# AI Ticket System - Debug and Setup Script
Write-Host "============================================" -ForegroundColor Green
Write-Host "AI TICKET SYSTEM - DEBUG & SETUP" -ForegroundColor Green  
Write-Host "============================================" -ForegroundColor Green

# Function to check if MongoDB is running
function Test-MongoDB {
    Write-Host "`nChecking MongoDB connection..." -ForegroundColor Yellow
    try {
        $mongoTest = mongosh --eval "db.runCommand({ ping: 1 })" --quiet 2>$null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ MongoDB is running!" -ForegroundColor Green
            return $true
        }
    } catch {
        Write-Host "❌ MongoDB is not running or not installed" -ForegroundColor Red
        Write-Host "Please install MongoDB or use MongoDB Atlas" -ForegroundColor Yellow
        return $false
    }
    return $false
}

# Function to test API endpoints
function Test-APIEndpoints {
    Write-Host "`nTesting API endpoints..." -ForegroundColor Yellow
    
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:3000/api/auth/users" -Method GET -TimeoutSec 5 2>$null
        Write-Host "✅ Backend API is responding!" -ForegroundColor Green
    } catch {
        Write-Host "❌ Backend API is not responding" -ForegroundColor Red
        Write-Host "Make sure to start the backend server first" -ForegroundColor Yellow
    }
}

# Check environment files
Write-Host "`n1. Checking environment files..." -ForegroundColor Cyan

$backendEnvPath = ".\ai-ticket-assistant\.env"
$frontendEnvPath = ".\ai-ticket-frontend\.env"

if (Test-Path $backendEnvPath) {
    Write-Host "✅ Backend .env file exists" -ForegroundColor Green
    
    $envContent = Get-Content $backendEnvPath
    $mongoUri = ($envContent | Where-Object { $_ -like "MONGO_URI=*" }) -replace "MONGO_URI=", ""
    
    if ([string]::IsNullOrWhiteSpace($mongoUri)) {
        Write-Host "⚠️  MONGO_URI is empty in backend .env" -ForegroundColor Yellow
        Write-Host "   Please add your MongoDB connection string" -ForegroundColor Yellow
        Write-Host "   Example: MONGO_URI=mongodb://localhost:27017/ai-tickets" -ForegroundColor Cyan
        Write-Host "   Or use MongoDB Atlas: MONGO_URI=mongodb+srv://user:pass@cluster.mongodb.net/ai-tickets" -ForegroundColor Cyan
    } else {
        Write-Host "✅ MONGO_URI is configured" -ForegroundColor Green
    }
} else {
    Write-Host "❌ Backend .env file missing" -ForegroundColor Red
}

if (Test-Path $frontendEnvPath) {
    Write-Host "✅ Frontend .env file exists" -ForegroundColor Green
} else {
    Write-Host "❌ Frontend .env file missing" -ForegroundColor Red
}

# Check if node_modules exist
Write-Host "`n2. Checking dependencies..." -ForegroundColor Cyan

if (Test-Path ".\ai-ticket-assistant\node_modules") {
    Write-Host "✅ Backend dependencies installed" -ForegroundColor Green
} else {
    Write-Host "❌ Backend dependencies missing - run: cd ai-ticket-assistant && npm install" -ForegroundColor Red
}

if (Test-Path ".\ai-ticket-frontend\node_modules") {
    Write-Host "✅ Frontend dependencies installed" -ForegroundColor Green
} else {
    Write-Host "❌ Frontend dependencies missing - run: cd ai-ticket-frontend && npm install" -ForegroundColor Red
}

# Test MongoDB connection
Test-MongoDB

# Show startup instructions
Write-Host "`n============================================" -ForegroundColor Green
Write-Host "STARTUP INSTRUCTIONS" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`n1. Start Backend (in terminal 1):" -ForegroundColor Cyan
Write-Host "   cd ai-ticket-assistant" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor White

Write-Host "`n2. Start Inngest (in terminal 2):" -ForegroundColor Cyan  
Write-Host "   cd ai-ticket-assistant" -ForegroundColor White
Write-Host "   npm run inngest-dev" -ForegroundColor White

Write-Host "`n3. Start Frontend (in terminal 3):" -ForegroundColor Cyan
Write-Host "   cd ai-ticket-frontend" -ForegroundColor White
Write-Host "   npm run dev" -ForegroundColor White

Write-Host "`n4. Access the application:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:5173" -ForegroundColor White
Write-Host "   Backend API: http://localhost:3000/api" -ForegroundColor White
Write-Host "   Inngest Dev: http://localhost:8288" -ForegroundColor White

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "ENVIRONMENT CONFIGURATION" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`nIf you need to set up MongoDB:" -ForegroundColor Cyan
Write-Host "Option 1 - Local MongoDB:" -ForegroundColor Yellow
Write-Host "   MONGO_URI=mongodb://localhost:27017/ai-tickets" -ForegroundColor White

Write-Host "`nOption 2 - MongoDB Atlas (Free):" -ForegroundColor Yellow
Write-Host "   1. Go to https://www.mongodb.com/atlas" -ForegroundColor White
Write-Host "   2. Create free account and cluster" -ForegroundColor White
Write-Host "   3. Get connection string" -ForegroundColor White
Write-Host "   4. Update MONGO_URI in ai-ticket-assistant\.env" -ForegroundColor White

Write-Host "`n============================================" -ForegroundColor Green

# Offer to run quick tests if backend might be running
$testAPI = Read-Host "`nDo you want to test if the backend is running? (y/n)"
if ($testAPI -eq "y" -or $testAPI -eq "Y") {
    Test-APIEndpoints
}

Write-Host "`nSetup check completed!" -ForegroundColor Green