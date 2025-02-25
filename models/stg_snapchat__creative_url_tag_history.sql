
with base as (

    select * 
    from {{ ref('stg_snapchat__creative_url_tag_history_tmp') }}

),

fields as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_snapchat__creative_url_tag_history_tmp')),
                staging_columns=get_creative_url_tag_history_columns()
            )
        }}
        
    from base
),

final as (
    
    select  
        creative_id,
        key as param_key,
        value as param_value
    from fields
)

select * from final
