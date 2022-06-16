with source as (

    select * from {{ source( 'greenery', 'users' ) }}

),

renamed as (

    select 
        user_id as id
        , first_name
        , last_name
        , first_name || ' ' || last_name as full_name
        , email
        , phone_number
        , created_at as created_at_utc
        , updated_at as updated_at_utc
        , address_id 

    from
        source

)

select * from renamed