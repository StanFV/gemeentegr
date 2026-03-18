-- =============================================
-- Hardenberg Zetelsplits — Supabase setup
-- Voer dit uit in: Supabase > SQL Editor
-- =============================================

-- 1. Maak de tabel aan
CREATE TABLE predictions (
  id            uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  name          text NOT NULL UNIQUE,       -- naam van de deelnemer (uniek → upsert werkt)
  prediction    jsonb NOT NULL,             -- zetelverdeling als JSON object
  submitted_at  timestamptz DEFAULT now()   -- tijdstip van invullen
);

-- 2. Zorg dat iedereen (anoniem) kan lezen én schrijven
--    (de app gebruikt de anon key, dus RLS moet dit toestaan)
ALTER TABLE predictions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Iedereen kan voorspellingen lezen"
  ON predictions FOR SELECT
  USING (true);

CREATE POLICY "Iedereen kan voorspelling invoegen"
  ON predictions FOR INSERT
  WITH CHECK (true);

CREATE POLICY "Iedereen kan eigen naam upserten"
  ON predictions FOR UPDATE
  USING (true)
  WITH CHECK (true);

-- 3. Klaar! Test met:
-- SELECT * FROM predictions;
