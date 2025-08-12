# Bike Share & Weather Analysis

This project integrates bike share ridership data with local weather data to provide actionable insights for analysts and decision-makers. It demonstrates my ability to clean, transform, and model data for analytics, as well as to design a relational database and create views that simplify complex queries.

---

## Development Process

### Data Cleaning & Transformation
During the exploratory data analysis stage, I identified several inconsistencies and missing values in the raw data.

- **Weather Data Alignment:**  
  Weather data did not directly align with trip data; some trips lacked a matching `weather_id`. I handled this by performing left joins where possible, ensuring trips without weather data could still appear in aggregated counts.

- **Invalid Trip Durations:**  
  Some records had zero or negative trip durations. I flagged these in the `data_quality_issues` view rather than deleting them, so analysts can decide whether to exclude them.

- **Date & Time Standardization:**  
  Converted timestamps to uniform formats, extracted components (e.g., hour of day) for analysis, and ensured all durations were in minutes.

These cleaning decisions ensured that downstream queries are based on consistent, analyzable data while preserving problematic rows for audit and data quality tracking.

---

### Database Schema Design
I designed the relational database to support efficient joins and clear relationships:

- **`bike_trips` Table:** Core fact table with trip IDs, start/end station references, user IDs, weather IDs, timestamps, and durations.
- **`stations` Table:** Lookup for station IDs, names, and metadata.
- **`bike_users` Table:** User information such as type (casual vs. subscriber).
- **`weather` Table:** Daily weather data, keyed by `id`, containing temperature, precipitation, and snowfall.

This schema enables flexible querying for various analyses (ridership trends, weather correlations, user behavior, station usage) without excessive data duplication.

---

### Views Created & Their Usefulness
I created several SQL views to encapsulate commonly used queries and analytical perspectives:

1. **`daily_ridership_weather`**  
   Aggregates total trips and average trip duration per day alongside temperature and precipitation.  
   _Use case:_ Daily trend analysis and seasonal weather impact studies.

2. **`hourly_ridership`**  
   Breaks down trips by hour of day with temperature context.  
   _Use case:_ Peak usage identification and operational planning.

3. **`weather_trip_duration`**  
   Shows average trip duration by day along with precipitation/snowfall.  
   _Use case:_ Determine if adverse weather shortens trips.

4. **`user_weather_behavior`**  
   Compares trip counts by user type (subscriber vs. casual) against weather conditions.  
   _Use case:_ Understand how different rider segments respond to weather.

5. **`station_usage_weather`**  
   Tracks start and end trip counts for each station with temperature context.  
   _Use case:_ Station-level demand planning.

6. **`data_quality_issues`**  
   Flags trips with missing weather data or invalid durations.  
   _Use case:_ Ongoing data quality monitoring.

By encapsulating these queries into views, I made it easier for analysts to explore key business questions without rewriting complex SQL joins and aggregations.

---

## Why These Decisions Were Made
The goal was to create a clean, reliable, and analyst-friendly data environment. By designing the schema around logical entities, cleaning and preserving problematic data, and pre-building views for common analytical needs, I ensured that both technical and non-technical stakeholders can access meaningful insights quickly.  
This approach balances technical best practices with business usability.

---

## Technical Stack
- **Database:** PostgreSQL
- **Data Cleaning & Transformation:** Python (Pandas), SQL
- **Analysis & Visualization:** SQL queries, Jupyter Notebook
- **Version Control:** Git & GitHub
- **File Formats:** CSV (raw data), SQL scripts

---

## Next Steps
- **Enhance Weather Matching:** Improve granularity by linking hourly weather data to trips.
- **Additional Quality Checks:** Add automated data validation scripts before database ingestion.
- **Visualization Dashboard:** Build an interactive dashboard (e.g., Tableau or Plotly Dash) for non-technical stakeholders.
- **Performance Optimization:** Add indexes to high-usage columns for faster query execution.

---

## Author
**Zac Adeboye**  
[LinkedIn](https://www.linkedin.com/) | [GitHub](https://github.com/)
