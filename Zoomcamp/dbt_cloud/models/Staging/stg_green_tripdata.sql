with 

source as (

    select * from `daring-octane-409806`.`ny_taxi`.`green_tripdata_2019`

),

renamed as (

    select
        to_hex(md5(cast(coalesce(cast(vendor_id as string), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(pickup_datetime as string), '_dbt_utils_surrogate_key_null_') as string))) as tripid,
        vendor_id,
        pickup_datetime,
        dropoff_datetime,
        store_and_fwd_flag,
        rate_code,
        passenger_count,
        trip_distance,
        fare_amount,
        extra,
        mta_tax,
        tip_amount,
        tolls_amount,
        ehail_fee,
        airport_fee,
        total_amount,
        payment_type,
        case 
    safe_cast(payment_type as INT64)
  
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
        else 'EMPTY'
    end as payment_type_descripted,
        distance_between_service,
        time_between_service,
        trip_type,
        imp_surcharge,
        pickup_location_id,
        dropoff_location_id,
        data_file_year,
        data_file_month

    from source

)

select * from renamed