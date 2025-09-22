# Complete MongoDB Setup Script
Write-Host "============================================" -ForegroundColor Green
Write-Host "COMPLETE MONGODB ATLAS SETUP" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`nYour MongoDB connection string has been added to the .env file!" -ForegroundColor Green
Write-Host "Current connection string:" -ForegroundColor Cyan
Write-Host "mongodb+srv://hellofrom1000_db_user:<db_password>@cluster0.qipxbm2.mongodb.net/ai-tickets?retryWrites=true&w=majority&appName=Cluster0" -ForegroundColor Yellow

Write-Host "`n⚠️  IMPORTANT: You need to replace <db_password> with your actual database password" -ForegroundColor Red

Write-Host "`nTo find your database password:" -ForegroundColor Cyan
Write-Host "1. Go to https://cloud.mongodb.com" -ForegroundColor White
Write-Host "2. Sign in to your MongoDB Atlas account" -ForegroundColor White  
Write-Host "3. Go to Database Access (in the left sidebar)" -ForegroundColor White
Write-Host "4. Find your user 'hellofrom1000_db_user'" -ForegroundColor White
Write-Host "5. If you forgot the password, click 'Edit' and set a new password" -ForegroundColor White

Write-Host "`nOptions to update the password:" -ForegroundColor Cyan

Write-Host "`nOption 1 - Manual Edit:" -ForegroundColor Yellow
Write-Host "1. Open: ai-ticket-assistant\.env" -ForegroundColor White
Write-Host "2. Replace <db_password> with your actual password" -ForegroundColor White
Write-Host "3. Save the file" -ForegroundColor White

Write-Host "`nOption 2 - Use this script:" -ForegroundColor Yellow
$updatePassword = Read-Host "Do you want to enter your password now? (y/n)"

if ($updatePassword -eq "y" -or $updatePassword -eq "Y") {
    $password = Read-Host "Enter your MongoDB database password" -AsSecureString
    $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
    
    # Update the .env file
    $envPath = ".\ai-ticket-assistant\.env"
    $envContent = Get-Content $envPath -Raw
    $updatedContent = $envContent -replace '<db_password>', $plainPassword
    Set-Content -Path $envPath -Value $updatedContent
    
    Write-Host "`n✅ Password updated in .env file!" -ForegroundColor Green
    
    # Test connection
    Write-Host "`nTesting MongoDB connection..." -ForegroundColor Cyan
    Set-Location ".\ai-ticket-assistant"
    
    # Create a simple test script
    $testScript = @"
import mongoose from 'mongoose';
import dotenv from 'dotenv';
dotenv.config();

console.log('Testing MongoDB connection...');
mongoose.connect(process.env.MONGO_URI)
  .then(() => {
    console.log('✅ MongoDB connected successfully!');
    process.exit(0);
  })
  .catch((err) => {
    console.error('❌ MongoDB connection failed:', err.message);
    process.exit(1);
  });
"@
    
    Set-Content -Path "test-mongo.js" -Value $testScript
    
    try {
        $result = node test-mongo.js 2>&1
        Write-Host $result -ForegroundColor Green
        Remove-Item "test-mongo.js" -Force
    } catch {
        Write-Host "❌ Connection test failed. Please check your password." -ForegroundColor Red
        Remove-Item "test-mongo.js" -Force -ErrorAction SilentlyContinue
    }
    
    Set-Location ".."
} else {
    Write-Host "`n⚠️  Remember to update the password in ai-ticket-assistant\.env before starting the application!" -ForegroundColor Yellow
}

Write-Host "`n============================================" -ForegroundColor Green
Write-Host "NEXT STEPS" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Green

Write-Host "`n1. Make sure your password is updated in the .env file" -ForegroundColor Cyan
Write-Host "2. Run the debug script to verify everything:" -ForegroundColor Cyan
Write-Host "   .\debug-setup.ps1" -ForegroundColor White
Write-Host "3. Start all services:" -ForegroundColor Cyan  
Write-Host "   .\start-all.ps1" -ForegroundColor White
Write-Host "4. Open http://localhost:5173 and test the application!" -ForegroundColor Cyan

Write-Host "`nSetup completed! 🎉" -ForegroundColor Green