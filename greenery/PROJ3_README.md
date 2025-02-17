# Week 3 Project 

What is our overall conversion rate?
 ```sql
    select
    round ( sum(case when checkout > 0 then 1 else 0 end)
    / count(session_id) :: numeric * 100 , 2 ) || '%' as conversion_rate
    
    from dbt_insuh_p.fct_unique_sessions_events
 ```
> 62.46%

What is our conversion rate by product?
``` sql
    select * from dbt_insuh_p.fct_unique_product_events
```
|product_id|product_name|product_price|product_inventory|product_conversion_rate|
|---|---|---|---|---|
|6f3a3072-a24d-4d11-9cef-25b0b5f8a4af|Alocasia Polly|95|83|41.18%|
|615695d3-8ffd-4850-bcf7-944cf6d3685b|Aloe Vera|15|47|49.23%|
|58b575f2-2192-4a53-9d21-df9a0c14fc25|Angel Wings Begonia|95|65|39.34%|
|74aeb414-e3dd-4e8a-beef-0fa45225214d|Arrow Head|30.95|100|55.56%|
|689fb64e-a4a2-45c5-b9f2-480c2155624d|Bamboo|15.25|56|53.73%|
|05df0866-1a66-41d8-9ed7-e2bbcddd6a3d|Bird of Paradise|65|97|45.00%|
|bb19d194-e1bd-4358-819e-cd1f1b401c0c|Birds Nest Fern|15.5|49|42.31%|
|e2e78dfc-f25c-4fec-a002-8e280d61a2f2|Boston Fern|20|77|41.27%|
|c17e63f7-0d28-4a95-8248-b01ea354840e|Cactus|15|81|54.55%|
|b86ae24b-6f59-47e8-8adc-b17d88cbd367|Calathea Makoyana|40.25|94|50.94%|
|35550082-a52d-4301-8f06-05b30f6f3616|Devil's Ivy|15.25|88|48.89%|
|37e0062f-bd15-4c3e-b272-558a86d90598|Dragon Tree|50.25|73|46.77%|
|843b6553-dc6a-4fc4-bceb-02cd39af0168|Ficus|20.25|44|42.65%|
|e706ab70-b396-4d30-a6b2-a1ccf3625b52|Fiddle Leaf Fig|85.5|82|50.00%|
|a88a23ef-679c-4743-b151-dc7722040d8c|Jade Plant|15|94|47.83%|
|5ceddd13-cf00-481f-9285-8340ab95d06d|Majesty Palm|70|74|49.25%|
|d3e228db-8ca5-42ad-bb0a-2148e876cc59|Money Tree|30.5|59|46.43%|
|be49171b-9f72-4fc9-bf7a-9a52e259836b|Monstera|50.75|77|51.02%|
|c7050c3b-a898-424d-8d98-ab0aaad7bef4|Orchid|50.75|58|45.33%|
|e5ee99b6-519f-4218-8b41-62f48f59f700|Peace Lily|60.5|99|40.91%|
|55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3|Philodendron|45|51|48.39%|
|5b50b820-1d0a-4231-9422-75e7f6b0cecf|Pilea Peperomioides|20.5|85|47.46%|
|80eda933-749d-4fc6-91d5-613d29eb126f|Pink Anthurium|60.95|95|41.89%|
|e18f33a6-b89a-4fbc-82ad-ccba5bb261cc|Ponytail Palm|80.75|93|40.00%|
|4cda01b9-62e2-46c5-830f-b7f262a58fb1|Pothos|30.5|40|34.43%|
|579f4cd0-1f45-49d2-af55-9ab2b72c3b35|Rubber Plant|20.5|92|51.85%|
|e8b6528e-a830-4d03-a027-473b411c7f02|Snake Plant|25.5|48|39.73%|
|64d39754-03e4-4fa0-b1ea-5f4293315f67|Spider Plant|15|67|47.46%|
|fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80|String of pearls|80.5|58|60.94%|
|b66a7143-c18a-43bb-b5dc-06bb5d1d3160|ZZ Plant|25|89|53.97%|
