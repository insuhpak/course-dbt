with source as (

    select * from {{ source( 'greenery', 'products' ) }}

),

renamed as (

    select
        product_id as id
        , name
        , price
        , inventory

    from
        source

)

select * from renamed