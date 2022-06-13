with source as (

    select * from {{ source( 'greenery', 'promos' ) }}

),

renamed as (

    select
        promo_id as id,
        discount,
        status
    
    from
        source

)

select * from source