# Our Wellness Diary — Deployment Guide

## What's in this project
- `index.html` — Full website (connected to Supabase)
- `supabase_setup.sql` — Run this in Supabase to create all tables

---

## STEP 1 — Set up Supabase Database

1. Go to https://supabase.com → your project (wellness-diary)
2. Click **SQL Editor** in left sidebar
3. Click **New Query**
4. Open `supabase_setup.sql` from this folder, copy ALL the text
5. Paste it into the SQL Editor
6. Click **Run** (green button)
7. You should see "Success" — all tables are created with sample data

---

## STEP 2 — Create Admin Account in Supabase

1. In Supabase → go to **Authentication** → **Users**
2. Click **Add User** → **Create New User**
3. Enter your email and a strong password
4. Click **Create User**
5. This is your admin login for the website

---

## STEP 3 — Push to GitHub

Open Terminal (or Command Prompt) in this folder and run these commands ONE BY ONE:

```bash
git init
git add .
git commit -m "Initial commit — Our Wellness Diary website"
git branch -M main
git remote add origin https://github.com/owdcommunity-hue/wellness-diary.git
git push -u origin main
```

When it asks for username: type your GitHub username
When it asks for password: paste your GitHub token (ghp_...)

---

## STEP 4 — Create GitHub Repository

Before Step 3, create the repo on GitHub:
1. Go to https://github.com/new
2. Repository name: `wellness-diary`
3. Keep it **Public**
4. Do NOT tick "Add README" (we already have files)
5. Click **Create Repository**
6. Then run the commands in Step 3

---

## STEP 5 — Deploy on Vercel

1. Go to https://vercel.com → **Add New Project**
2. Click **Import Git Repository**
3. Find `wellness-diary` and click **Import**
4. Framework Preset: select **Other**
5. Click **Deploy**
6. Wait 1–2 minutes
7. Your site is LIVE at something like `wellness-diary.vercel.app`

---

## STEP 6 — Test Everything

1. Open your live Vercel URL
2. Check videos, classes, and diet plans load
3. Try subscribing with a test email
4. Click Admin ⚙ → log in with your Supabase auth email/password
5. Add a test video — confirm it appears on the site

---

## How to Update the Site Later

Whenever you want to add videos or change anything via code:
```bash
git add .
git commit -m "describe what you changed"
git push
```
Vercel auto-deploys within 30 seconds.

For content updates (videos, classes, diet plans) — just use the Admin panel on the live site.

---

## Important Security Notes

- Never share your Supabase **secret key** (only the publishable/anon key is in the code — that's safe)
- Your admin password is stored securely in Supabase Auth (not in the code)
- Row Level Security is enabled — public users can only read content and submit forms
- Only logged-in admins can add/delete content
