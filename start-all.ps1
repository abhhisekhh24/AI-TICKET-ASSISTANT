# AI Ticket System - Quick Start Script
Write-Host "============================================" -ForegroundColor Green
Write-Host "AI TICKET SYSTEM - QUICK START" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`nThis script will open 3 terminal windows to start all services." -ForegroundColor Yellow
Write-Host "Make sure you have set up MongoDB connection in ai-ticket-assistant\.env" -ForegroundColor Yellow

$confirm = Read-Host "`nDo you want to continue? (y/n)"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Cancelled." -ForegroundColor Red
    exit
}

$currentDir = Get-Location

# Start Backend Server
Write-Host "`nStarting Backend Server..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$currentDir\ai-ticket-assistant'; Write-Host 'Starting Backend Server...' -ForegroundColor Green; npm run dev"

# Wait a moment
Start-Sleep -Seconds 2

# Start Inngest Dev Server  
Write-Host "Starting Inngest Dev Server..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$currentDir\ai-ticket-assistant'; Write-Host 'Starting Inngest Dev Server...' -ForegroundColor Green; npm run inngest-dev"

# Wait a moment
Start-Sleep -Seconds 2

# Start Frontend
Write-Host "Starting Frontend..." -ForegroundColor Cyan
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$currentDir\ai-ticket-frontend'; Write-Host 'Starting Frontend...' -ForegroundColor Green; npm run dev"

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "SERVERS STARTING IN SEPARATE WINDOWS" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`nServers are starting in separate terminal windows:" -ForegroundColor Cyan
Write-Host "1. Backend API: http://localhost:3000" -ForegroundColor White
Write-Host "2. Inngest Dev: http://localhost:8288" -ForegroundColor White  
Write-Host "3. Frontend: http://localhost:5173" -ForegroundColor White

Write-Host "`nWait for all servers to start, then:" -ForegroundColor Yellow
Write-Host "- Open http://localhost:5173 in your browser" -ForegroundColor White
Write-Host "- Create an account and test the application" -ForegroundColor White

Write-Host "`nTo stop all servers: Close each terminal window or press Ctrl+C in each" -ForegroundColor Yellow

Write-Host "`nDone!" -ForegroundColor Green