drop table if exists output.lab_months;

create table output.lab_months as (
    select lab_id, sample_type,
        date_trunc('month', sample_date) as month,
        count(*) as count,
        mode() WITHIN GROUP (ORDER BY bll ASC) as bll_mode,
        percentile_disc(ARRAY[.05,.10,.15,.20]) WITHIN GROUP (ORDER BY bll ASC) as bll_percentiles
    from aux.tests
    group by 1,2,3
);