with CTE as
    (select sys_id -- ,number_case
-- ,active
-- ,state
-- ,"case"
,
            short_description -- ,u_html_description
-- ,account
-- ,u_case_attribute
-- ,u_case_attribute_nlp
-- ,u_ci_product_nlp
-- ,u_topic_nlp
-- ,impact
-- ,u_entity
,
            u_case_category,
            u_case_subcategory -- ,u_client_category
-- ,u_client_subcategory
-- ,category
-- ,subcategory
-- ,opened_by
-- ,opened_at
,
            resolved_by,
            resolved_at AT TIME ZONE 'America/New_York' AS resolved_at_eastern,
                                     closed_by, -- ,closed_at
 resolution_code -- ,priority
-- ,u_health_score
-- ,u_client_application
-- ,parent
-- ,parent_case
-- ,caused_by
-- ,watch_list
-- ,active_escalation
-- ,upon_reject
-- ,support_manager
-- ,u_cancelled_reason
-- ,approval_history
-- ,u_agent_comments
-- ,skills
-- ,problem
-- ,u_client_configuration_item
-- ,u_client_contact_type
-- ,initiated_as_request
-- ,u_business_impact
-- ,u_impact_prediction_temp
-- ,knowledge
-- ,"order"
-- ,assigned_on
,
 u_agio_service -- ,cmdb_ci
-- ,delivery_plan
-- ,contract
-- ,work_notes_list
-- ,auto_created_case
-- ,sys_domain_path
-- ,business_duration
-- ,first_response_time
-- ,group_list
-- ,u_template
-- ,child_case_creation_progress
-- ,sync_driver
-- ,u_read
-- ,approval_set
-- ,u_internal_threat
-- ,needs_attention
-- ,correlation_display
-- ,delivery_task
-- ,work_start
-- ,x_agite_agiosurvey_send_survey
-- ,additional_assignee_list
-- ,recipient_list
-- ,u_original_email_from_address
-- ,u_associated_to_a_case
-- ,notify
-- ,service_offering
-- ,sys_class_name
-- ,follow_up
-- ,sold_product
-- ,contact_local_time
-- ,sn_app_cs_social_social_profile
-- ,u_business_impact_source
-- ,reassignment_count
-- ,u_session_uuid
-- ,contact_time_zone
-- ,notes_to_comments
-- ,assigned_to
-- ,product
-- ,sla_due
-- ,change
-- ,comments_and_work_notes
-- ,u_comments_updated_by
-- ,partner
-- ,escalation
-- ,upon_approval
-- ,partner_contact
-- ,correlation_id
-- ,u_client_source_system
-- ,asset
-- ,made_sla
-- ,u_client_escalation_reason
-- ,u_original_email_to_address
-- ,u_client_correlation_id
-- ,user_input
-- ,contact
-- ,sys_domain
-- ,u_estimation_effort
-- ,u_maintenance_schedule
-- ,u_install_base_item
-- ,follow_the_sun
-- ,business_service
-- ,entitlement
-- ,business_impact
-- ,u_client_business_service
-- ,u_time_card_needed
-- ,time_worked
-- ,expected_start
-- ,work_end
-- ,case_report
-- ,work_notes
-- ,assignment_group
-- ,u_client_ref_code
-- ,cause
-- ,description
-- ,proactive
-- ,calendar_duration
-- ,u_client_assignment_group
,
 close_notes -- ,u_originating_record
-- ,auto_close
-- ,contact_type
-- ,alert
-- ,probable_cause
-- ,urgency
-- ,company
-- ,u_originating_system
-- ,activity_due
-- ,consumer
-- ,major_case_state
-- ,action_status
-- ,u_account_name
-- ,x_agite_epi_sentim_score
-- ,comments
-- ,u_comments_updated_count
-- ,u_comments_last_updated
-- ,approval
-- ,due_date
-- ,sys_mod_count
-- ,u_traceless
-- ,u_case_opened_by
-- ,sys_tags
-- ,active_account_escalation
-- ,location
-- ,incident
-- ,sys_created_on
-- ,sys_created_by
-- ,sys_updated_on
-- ,sys_updated_by
-- ,load_datetime
,
 u_html_description_clean -- ,agio_service
-- ,prev_case_type_group
-- ,state_description
-- ,impact_description
-- ,number_case_parent
-- ,short_description_parent
-- ,parent_opened_at
-- ,parent_resolved_at
-- ,parent_closed_at
-- ,parent_state_description
-- ,time_to_resolve
-- ,time_to_resolve_secs
,
 is_noise,
 is_generic_data -- ,is_agio_internal
-- ,is_agio_owned
-- ,is_compass_eligible
-- ,name_customer_account
-- ,account_id_salesforce
,
 assignment_group_name -- ,parent_assignment_group_name
-- ,case_sentiment
-- ,is_first_touch_resolved
-- ,count_email_interactions
-- ,time_worked_seconds
-- ,on_hold_duration_secs
-- ,awaiting_info_duration_secs
-- ,opened_at_date_eastern
-- ,nlp_case_attribute
-- ,nlp_ci_product
-- ,nlp_topic
-- ,case_type_group
,
 channel
     from warehouse.case_expanded
     where is_compass_eligible = 'yes'
         AND resolution_code not in ('Solved by Parent Case',
                                     'Noise - Duplicate',
                                     'Noise - Informational',
                                     'Noise - Alert Cleared/Auto Resolved',
                                     'Solved by Parent Incident/Case')
         AND is_noise = 'no'
         AND is_generic_data = 'no'
         AND resolved_by not in ('sys_user/e749fee7dbf73c10dcf93313e2961911') ), --AND resolution_code != 'Noise - Informational' ),
users as
    (select sys_id as user_sys_id,
            "user_name" as resolved_by_user_name
     from warehouse_snow.curr_snow_sys_user)
select *
FROM cte
join users on cte.resolved_by= users.user_sys_id --

where resolved_at_eastern <='11/25/22' --                                     'svcEBondedOHA')
-- limit 10000