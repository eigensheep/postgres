-- Function: public.pg_stat_activity()

-- DROP FUNCTION public.pg_stat_activity();

CREATE OR REPLACE FUNCTION public.pg_stat_activity()
  RETURNS SETOF pg_stat_activity AS
$BODY$
DECLARE
 rec RECORD;
BEGIN
    -- Author: Tony Wasson (part of nagiosplugins for postgresql)
    -- Overview: Let non super users see query details from pg_stat_activity
    -- Revisions: (when, who, what)
    --   2006-08-29 TW - Checked into CVS after a user request.
    FOR rec IN SELECT * FROM pg_stat_activity
    LOOP
        RETURN NEXT rec;
    END LOOP;
    RETURN;
END;
$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100
  ROWS 1000;
ALTER FUNCTION public.pg_stat_activity()
  OWNER TO postgres;
