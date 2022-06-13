with source as (

    select * from {{ source( 'greenery', 'order_items' ) }}

),

renamed as (

    select
        order_id as id,
        product_id, 
        quantity

    from 
        source

)

select * from renamed