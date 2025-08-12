CREATE OR REPLACE VIEW daily_ridership_weather AS
SELECT
    w.date,
    w.day_of_week,
    COUNT(bt.trip_id) AS total_trips,
    AVG(bt.trip_duration_minutes) AS average_trip_duration,
    w.average_temperature_f,
    w.precipitation_inches,
    w.snowfall_inches
FROM weather w
LEFT JOIN bike_trips bt ON bt.weather_id = w.id
GROUP BY w.date, w.day_of_week, w.average_temperature_f, w.precipitation_inches, w.snowfall_inches
ORDER BY w.date ASC;

SELECT * FROM daily_ridership_weather;

CREATE OR REPLACE VIEW hourly_ridership AS
SELECT
    DATE(bt.start_time) AS date,
    EXTRACT(HOUR FROM bt.start_time) AS hour,
    COUNT(*) AS trip_count,
    w.average_temperature_f
FROM bike_trips bt
LEFT JOIN weather w ON bt.weather_id = w.id
GROUP BY DATE(bt.start_time), EXTRACT(HOUR FROM bt.start_time), w.average_temperature_f
ORDER BY date, hour;

CREATE OR REPLACE VIEW weather_trip_duration AS
SELECT
    w.date,
    AVG(bt.trip_duration_minutes) AS average_trip_duration,
    w.precipitation_inches,
    w.snowfall_inches,
    w.average_temperature_f
FROM weather w
LEFT JOIN bike_trips bt ON bt.weather_id = w.id
GROUP BY w.date, w.precipitation_inches, w.snowfall_inches, w.average_temperature_f
ORDER BY w.precipitation_inches DESC;

CREATE OR REPLACE VIEW user_weather_behavior AS
SELECT
    w.date,
    bu.user_type,
    COUNT(bt.trip_id) AS trip_count,
    w.average_temperature_f,
    w.precipitation_inches
FROM bike_trips bt
JOIN bike_users bu ON bt.user_id = bu.user_id
LEFT JOIN weather w ON bt.weather_id = w.id
GROUP BY w.date, bu.user_type, w.average_temperature_f, w.precipitation_inches
ORDER BY w.date, bu.user_type;

CREATE OR REPLACE VIEW station_usage_weather AS
SELECT
    w.date,
    s.station_id,
    s.station_name,
    COUNT(DISTINCT bt_start.trip_id) AS start_trip_count,
    COUNT(DISTINCT bt_end.trip_id) AS end_trip_count,
    w.average_temperature_f
FROM stations s
LEFT JOIN bike_trips bt_start ON s.station_id = bt_start.start_station_id
LEFT JOIN bike_trips bt_end ON s.station_id = bt_end.end_station_id
LEFT JOIN weather w ON bt_start.weather_id = w.id
GROUP BY w.date, s.station_id, s.station_name, w.average_temperature_f
ORDER BY start_trip_count DESC;

CREATE OR REPLACE VIEW data_quality_issues AS
SELECT
    bt.trip_id,
    bt.start_time,
    bt.trip_duration_minutes,
    bt.weather_id,
    CASE
        WHEN bt.weather_id IS NULL THEN 'Missing weather_id'
        WHEN bt.trip_duration_minutes <= 0 THEN 'Non-positive trip duration'
        ELSE NULL
    END AS issue
FROM bike_trips bt
WHERE bt.weather_id IS NULL OR bt.trip_duration_minutes <= 0
ORDER BY bt.start_time DESC;


