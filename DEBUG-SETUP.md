# AI Ticket System - Debug & Setup Guide

## 🚀 Quick Start

### Files Created for Debugging:
- ✅ `.env` files for both backend and frontend
- ✅ Missing `App.jsx` file for frontend
- ✅ Dependencies installed for both projects
- ✅ Debug scripts created

### Run the Debug Script:
```powershell
.\debug-setup.ps1
```

### Quick Start All Services:
```powershell
.\start-all.ps1
```

## 📋 Configuration Status

### Backend (.env) ✅
- ✅ JWT_SECRET configured
- ✅ Mailtrap SMTP configured
- ✅ Gemini API key configured
- ⚠️ **MONGO_URI needs to be set** (see below)

### Frontend (.env) ✅
- ✅ VITE_SERVER_URL configured to point to backend

## 🔧 MongoDB Setup (REQUIRED)

You need to set up MongoDB connection. Choose one option:

### Option 1: Local MongoDB
1. Install MongoDB locally
2. Update `ai-ticket-assistant\.env`:
```env
MONGO_URI=mongodb://localhost:27017/ai-tickets
```

### Option 2: MongoDB Atlas (Free, Recommended)
1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Create a free account and cluster
3. Get your connection string
4. Update `ai-ticket-assistant\.env`:
```env
MONGO_URI=mongodb+srv://username:password@cluster.mongodb.net/ai-tickets
```

## 🚀 Starting the Application

### Manual Start (3 terminals needed):

**Terminal 1 - Backend:**
```bash
cd ai-ticket-assistant
npm run dev
```

**Terminal 2 - Inngest:**
```bash
cd ai-ticket-assistant
npm run inngest-dev
```

**Terminal 3 - Frontend:**
```bash
cd ai-ticket-frontend
npm run dev
```

### Automatic Start:
```powershell
.\start-all.ps1
```

## 🌐 Access URLs

- **Frontend:** http://localhost:5173
- **Backend API:** http://localhost:3000/api
- **Inngest Dashboard:** http://localhost:8288

## 🧪 Testing

### Run API Tests:
```powershell
.\test-api.ps1
```

### Manual Testing Flow:
1. Open http://localhost:5173
2. Click "Sign Up" to create an account
3. Login with your credentials
4. Create a test ticket
5. Check the Inngest dashboard for AI processing

## 🔍 Troubleshooting

### Common Issues:

#### 1. MongoDB Connection Error
```
❌ MongoDB error: Could not connect
```
**Solution:** Set up MONGO_URI in backend .env file (see MongoDB Setup above)

#### 2. CORS Errors in Frontend
```
❌ Access to fetch blocked by CORS policy
```
**Solution:** Make sure backend server is running first

#### 3. AI Processing Not Working
```
❌ Gemini API error
```
**Solution:** Verify GEMINI_API_KEY is correct in backend .env

#### 4. Email Not Sending
```
❌ Mailtrap connection failed
```
**Solution:** Check Mailtrap credentials in backend .env

#### 5. Frontend Won't Load
```
❌ Cannot GET /
```
**Solution:** Make sure frontend is running on port 5173

## 📁 Project Structure

```
ai-ticket-system/
├── ai-ticket-assistant/          # Backend (Node.js)
│   ├── .env                     # ✅ Created
│   ├── package.json
│   ├── index.js
│   ├── controllers/
│   ├── models/
│   ├── routes/
│   └── inngest/
├── ai-ticket-frontend/           # Frontend (React)
│   ├── .env                     # ✅ Created
│   ├── package.json
│   ├── src/
│   │   ├── App.jsx              # ✅ Created (was missing)
│   │   ├── main.jsx
│   │   ├── components/
│   │   └── pages/
├── debug-setup.ps1              # ✅ Debug script
├── start-all.ps1                # ✅ Quick start script
├── test-api.ps1                 # ✅ API testing script
└── DEBUG-SETUP.md               # ✅ This file
```

## 🔑 Environment Variables Reference

### Backend (.env)
```env
# MongoDB (REQUIRED - ADD YOUR CONNECTION STRING)
MONGO_URI=

# Authentication
JWT_SECRET=ABHISEKH

# Email (Mailtrap)
MAILTRAP_SMTP_HOST=sandbox.smtp.mailtrap.io
MAILTRAP_SMTP_PORT=2525
MAILTRAP_SMTP_USER=4731f22addeee6
MAILTRAP_SMTP_PASS=cd3f8d5a58571d

# AI (Gemini)
GEMINI_API_KEY=AIzaSyBndEVnoi-aLQM75qqeoA6XwX3JDvxJZrM

# App
APP_URL=http://localhost:3000
```

### Frontend (.env)
```env
VITE_SERVER_URL=http://localhost:3000/api
```

## 📞 Support

If you're still having issues:
1. Run `.\debug-setup.ps1` to check your configuration
2. Check the console logs in each terminal
3. Verify all environment variables are set correctly
4. Make sure MongoDB is running and accessible

## ✅ Success Indicators

When everything is working:
- ✅ Backend shows "MongoDB connected ✅" and "🚀 Server at http://localhost:3000"
- ✅ Inngest shows development server running at http://localhost:8288
- ✅ Frontend shows "Local: http://localhost:5173"
- ✅ You can signup/login at http://localhost:5173
- ✅ Creating tickets triggers AI processing in Inngest dashboard