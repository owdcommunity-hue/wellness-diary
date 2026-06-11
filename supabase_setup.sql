-- ============================================
-- OUR WELLNESS DIARY — Supabase Database Setup
-- Run this entire file in Supabase SQL Editor
-- ============================================

-- 1. VIDEOS TABLE
create table if not exists videos (
  id uuid default gen_random_uuid() primary key,
  title text not null,
  playlist text not null,
  platform text not null default 'YouTube',
  duration text,
  emoji text default '🎥',
  url text,
  created_at timestamp with time zone default now()
);

-- 2. LIVE CLASSES TABLE
create table if not exists classes (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  day text not null,
  time text not null,
  type text not null,
  badge text,
  created_at timestamp with time zone default now()
);

-- 3. DIET PLANS TABLE
create table if not exists diet_plans (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  price text not null,
  description text,
  features text,
  emoji text default '🌿',
  created_at timestamp with time zone default now()
);

-- 4. SUBSCRIBERS TABLE
create table if not exists subscribers (
  id uuid default gen_random_uuid() primary key,
  name text,
  email text not null,
  phone text,
  goal text,
  type text default 'newsletter',
  created_at timestamp with time zone default now()
);

-- 5. DIET REQUESTS TABLE
create table if not exists diet_requests (
  id uuid default gen_random_uuid() primary key,
  name text not null,
  email text not null,
  age text,
  weight text,
  height text,
  goal text,
  diet_type text,
  conditions text,
  plan_name text,
  created_at timestamp with time zone default now()
);

-- ============================================
-- ROW LEVEL SECURITY (keeps data safe)
-- ============================================

alter table videos enable row level security;
alter table classes enable row level security;
alter table diet_plans enable row level security;
alter table subscribers enable row level security;
alter table diet_requests enable row level security;

-- Public can READ videos, classes, diet_plans (needed for website visitors)
create policy "Public read videos" on videos for select using (true);
create policy "Public read classes" on classes for select using (true);
create policy "Public read diet_plans" on diet_plans for select using (true);

-- Public can INSERT subscribers and diet_requests (form submissions)
create policy "Public insert subscribers" on subscribers for insert with check (true);
create policy "Public insert diet_requests" on diet_requests for insert with check (true);

-- Only authenticated admin can INSERT/UPDATE/DELETE videos, classes, diet_plans
create policy "Admin insert videos" on videos for insert with check (auth.role() = 'authenticated');
create policy "Admin delete videos" on videos for delete using (auth.role() = 'authenticated');
create policy "Admin insert classes" on classes for insert with check (auth.role() = 'authenticated');
create policy "Admin delete classes" on classes for delete using (auth.role() = 'authenticated');
create policy "Admin insert diet_plans" on diet_plans for insert with check (auth.role() = 'authenticated');
create policy "Admin delete diet_plans" on diet_plans for delete using (auth.role() = 'authenticated');

-- Only authenticated admin can READ subscribers and diet_requests
create policy "Admin read subscribers" on subscribers for select using (auth.role() = 'authenticated');
create policy "Admin read diet_requests" on diet_requests for select using (auth.role() = 'authenticated');

-- ============================================
-- SEED DEFAULT DATA
-- ============================================

insert into videos (title, playlist, platform, duration, emoji, url) values
('Sun Salutation for Absolute Beginners', 'Yoga', 'YouTube', '14:30', '🌞', ''),
('What I Eat in a Day — Vegetarian', 'Nutrition', 'YouTube', '18:42', '🥗', ''),
('My First Week of Yoga — Honest Vlog', 'Vlogs', 'YouTube', '22:10', '📝', ''),
('5-Minute Morning Stretch Routine', 'Yoga', 'Instagram', '5:00', '🌅', ''),
('Understanding Macros Simply', 'Nutrition', 'YouTube', '11:20', '📊', ''),
('Day 30 Yoga Journey Update', 'Vlogs', 'Instagram', '8:15', '🎉', '');

insert into classes (name, day, time, type, badge) values
('Morning Flow Yoga', 'Monday', '7:00 AM IST', 'Yoga', 'Beginner Friendly'),
('Nutrition & Meal Prep Talk', 'Wednesday', '6:30 PM IST', 'Nutrition Talk', 'Interactive'),
('Weekend Wellness Session', 'Saturday', '8:00 AM IST', 'Yoga', 'All Levels');

insert into diet_plans (name, price, description, features, emoji) values
('Weight Loss Starter', '799', 'A 4-week beginner plan designed around Indian kitchen staples.', '4-week meal plan,Shopping list,Macro breakdown,Whatsapp support,PDF format', '🌿'),
('Balance & Vitality', '1299', 'Hormonal balance, energy optimisation and mindful eating guide.', '6-week plan,Personalised adjustments,Yoga + diet integration,2 check-in calls,Recipe guide', '⚖️'),
('Custom 1-on-1 Plan', '2499', 'Fully personalised plan based on your health details and goals.', 'Deep health assessment,Custom meal plan,Weekly adjustment,4 video calls,Lifetime access', '✨');
