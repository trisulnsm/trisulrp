#!/usr/bin/env ruby
# Generated by the protocol buffer compiler. DO NOT EDIT!

require 'protocol_buffers'

module TRP
  # forward declarations
  class Timestamp < ::ProtocolBuffers::Message; end
  class TimeInterval < ::ProtocolBuffers::Message; end
  class StatsTuple < ::ProtocolBuffers::Message; end
  class MeterValues < ::ProtocolBuffers::Message; end
  class KeyStats < ::ProtocolBuffers::Message; end
  class KeyDetails < ::ProtocolBuffers::Message; end
  class SessionID < ::ProtocolBuffers::Message; end
  class AlertID < ::ProtocolBuffers::Message; end
  class ResourceID < ::ProtocolBuffers::Message; end
  class CounterGroupDetails < ::ProtocolBuffers::Message; end
  class Message < ::ProtocolBuffers::Message; end
  class HelloRequest < ::ProtocolBuffers::Message; end
  class HelloResponse < ::ProtocolBuffers::Message; end
  class ErrorResponse < ::ProtocolBuffers::Message; end
  class OKResponse < ::ProtocolBuffers::Message; end
  class ReleaseContextRequest < ::ProtocolBuffers::Message; end
  class CounterItemRequest < ::ProtocolBuffers::Message; end
  class CounterItemResponse < ::ProtocolBuffers::Message; end
  class BulkCounterItemRequest < ::ProtocolBuffers::Message; end
  class BulkCounterItemResponse < ::ProtocolBuffers::Message; end
  class CounterGroupRequest < ::ProtocolBuffers::Message; end
  class CounterGroupResponse < ::ProtocolBuffers::Message; end
  class FilteredDatagramRequest < ::ProtocolBuffers::Message; end
  class FilteredDatagramResponse < ::ProtocolBuffers::Message; end
  class ControlledContextRequest < ::ProtocolBuffers::Message; end
  class ControlledContextResponse < ::ProtocolBuffers::Message; end
  class SearchKeysRequest < ::ProtocolBuffers::Message; end
  class SearchKeysResponse < ::ProtocolBuffers::Message; end
  class CounterGroupInfoRequest < ::ProtocolBuffers::Message; end
  class CounterGroupInfoResponse < ::ProtocolBuffers::Message; end
  class SessionItemRequest < ::ProtocolBuffers::Message; end
  class SessionItemResponse < ::ProtocolBuffers::Message; end
  class TopperSnapshotRequest < ::ProtocolBuffers::Message; end
  class TopperSnapshotResponse < ::ProtocolBuffers::Message; end
  class UpdateKeyRequest < ::ProtocolBuffers::Message; end
  class KeySessionActivityRequest < ::ProtocolBuffers::Message; end
  class KeySessionActivityResponse < ::ProtocolBuffers::Message; end
  class SessionTrackerRequest < ::ProtocolBuffers::Message; end
  class SessionTrackerResponse < ::ProtocolBuffers::Message; end
  class SessionGroupRequest < ::ProtocolBuffers::Message; end
  class SessionGroupResponse < ::ProtocolBuffers::Message; end
  class ServerStatsRequest < ::ProtocolBuffers::Message; end
  class ServerStatsResponse < ::ProtocolBuffers::Message; end
  class AlertItemRequest < ::ProtocolBuffers::Message; end
  class AlertItemResponse < ::ProtocolBuffers::Message; end
  class AlertGroupRequest < ::ProtocolBuffers::Message; end
  class AlertGroupResponse < ::ProtocolBuffers::Message; end
  class ResourceItemRequest < ::ProtocolBuffers::Message; end
  class ResourceItemResponse < ::ProtocolBuffers::Message; end
  class ResourceGroupRequest < ::ProtocolBuffers::Message; end
  class ResourceGroupResponse < ::ProtocolBuffers::Message; end
  class KeyLookupRequest < ::ProtocolBuffers::Message; end
  class KeyLookupResponse < ::ProtocolBuffers::Message; end
  class GrepRequest < ::ProtocolBuffers::Message; end
  class GrepResponse < ::ProtocolBuffers::Message; end

  # enums
  module AuthLevel
    include ::ProtocolBuffers::Enum
    ADMIN = 1
    BASIC_USER = 2
    FORENSIC_USER = 3
    BLOCKED_USER = 4
  end

  module CompressionType
    include ::ProtocolBuffers::Enum
    UNCOMPRESSED = 1
    GZIP = 2
  end

  module PcapFormat
    include ::ProtocolBuffers::Enum
    LIBPCAP = 1
    UNSNIFF = 2
  end

  class Timestamp < ::ProtocolBuffers::Message
    required :int64, :tv_sec, 1
    required :int64, :tv_usec, 2, :default => 0

    gen_methods! # new fields ignored after this point
  end

  class TimeInterval < ::ProtocolBuffers::Message
    required ::TRP::Timestamp, :from, 1
    required ::TRP::Timestamp, :to, 2

    gen_methods! # new fields ignored after this point
  end

  class StatsTuple < ::ProtocolBuffers::Message
    required ::TRP::Timestamp, :ts, 1
    required :int64, :val, 2

    gen_methods! # new fields ignored after this point
  end

  class MeterValues < ::ProtocolBuffers::Message
    required :int32, :meter, 1
    repeated ::TRP::StatsTuple, :values, 2

    gen_methods! # new fields ignored after this point
  end

  class KeyStats < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    required :string, :key, 3
    repeated ::TRP::MeterValues, :meters, 4

    gen_methods! # new fields ignored after this point
  end

  class KeyDetails < ::ProtocolBuffers::Message
    required :string, :key, 1
    optional :string, :label, 2
    optional :string, :description, 3
    optional :int64, :metric, 4

    gen_methods! # new fields ignored after this point
  end

  class SessionID < ::ProtocolBuffers::Message
    required :int64, :slice_id, 1
    required :int64, :session_id, 2

    gen_methods! # new fields ignored after this point
  end

  class AlertID < ::ProtocolBuffers::Message
    required :int64, :slice_id, 1
    required :int64, :alert_id, 2

    gen_methods! # new fields ignored after this point
  end

  class ResourceID < ::ProtocolBuffers::Message
    required :int64, :slice_id, 1
    required :int64, :resource_id, 2

    gen_methods! # new fields ignored after this point
  end

  class CounterGroupDetails < ::ProtocolBuffers::Message
    required :string, :guid, 1
    required :string, :name, 2
    optional :int64, :bucket_size, 3
    optional ::TRP::TimeInterval, :time_interval, 4
    optional :int64, :topper_bucket_size, 5

    gen_methods! # new fields ignored after this point
  end

  class Message < ::ProtocolBuffers::Message
    # forward declarations

    # enums
    module Command
      include ::ProtocolBuffers::Enum
      HELLO_REQUEST = 1
      HELLO_RESPONSE = 2
      OK_RESPONSE = 3
      ERROR_RESPONSE = 5
      COUNTER_GROUP_REQUEST = 6
      COUNTER_GROUP_RESPONSE = 7
      COUNTER_ITEM_REQUEST = 8
      COUNTER_ITEM_RESPONSE = 9
      RELEASE_RESOURCE_REQUEST = 10
      RELEASE_CONTEXT_REQUEST = 11
      CONTROLLED_COUNTER_GROUP_REQUEST = 12
      CONTROLLED_COUNTER_GROUP_RESPONSE = 13
      FILTERED_DATAGRAMS_REQUEST = 14
      FILTERED_DATAGRAMS_RESPONSE = 15
      CONTROLLED_CONTEXT_REQUEST = 16
      CONTROLLED_CONTEXT_RESPONSE = 17
      SEARCH_KEYS_REQUEST = 18
      SEARCH_KEYS_RESPONSE = 19
      COUNTER_GROUP_INFO_REQUEST = 20
      COUNTER_GROUP_INFO_RESPONSE = 21
      SESSION_TRACKER_REQUEST = 22
      SESSION_TRACKER_RESPONSE = 23
      SESSION_ITEM_REQUEST = 24
      SESSION_ITEM_RESPONSE = 25
      BULK_COUNTER_ITEM_REQUEST = 26
      BULK_COUNTER_ITEM_RESPONSE = 27
      CGMONITOR_REQUEST = 28
      CGMONITOR_RESPONSE = 29
      TOPPER_SNAPSHOT_REQUEST = 30
      TOPPER_SNAPSHOT_RESPONSE = 31
      UPDATE_KEY_REQUEST = 32
      UPDATE_KEY_RESPONSE = 33
      KEY_SESS_ACTIVITY_REQUEST = 34
      KEY_SESS_ACTIVITY_RESPONSE = 35
      RING_STATS_REQUEST = 36
      RING_STATS_RESPONSE = 37
      SERVER_STATS_REQUEST = 38
      SERVER_STATS_RESPONSE = 39
      SESSION_GROUP_REQUEST = 40
      SESSION_GROUP_RESPONSE = 41
      ALERT_ITEM_REQUEST = 42
      ALERT_ITEM_RESPONSE = 43
      ALERT_GROUP_REQUEST = 44
      ALERT_GROUP_RESPONSE = 45
      RESOURCE_ITEM_REQUEST = 46
      RESOURCE_ITEM_RESPONSE = 47
      RESOURCE_GROUP_REQUEST = 48
      RESOURCE_GROUP_RESPONSE = 49
      KEY_LOOKUP_REQUEST = 50
      KEY_LOOKUP_RESPONSE = 51
      GREP_REQUEST = 60
      GREP_RESPONSE = 61
    end

    required ::TRP::Message::Command, :trp_command, 1
    optional ::TRP::HelloRequest, :hello_request, 2
    optional ::TRP::HelloResponse, :hello_response, 3
    optional ::TRP::OKResponse, :ok_response, 4
    optional ::TRP::ErrorResponse, :error_response, 5
    optional ::TRP::CounterGroupRequest, :counter_group_request, 6
    optional ::TRP::CounterGroupResponse, :counter_group_response, 7
    optional ::TRP::CounterItemRequest, :counter_item_request, 8
    optional ::TRP::CounterItemResponse, :counter_item_response, 9
    optional ::TRP::ReleaseContextRequest, :release_context_request, 11
    optional ::TRP::FilteredDatagramRequest, :filtered_datagram_request, 14
    optional ::TRP::FilteredDatagramResponse, :filtered_datagram_response, 15
    optional ::TRP::ControlledContextRequest, :controlled_context_request, 16
    optional ::TRP::ControlledContextResponse, :controlled_context_response, 17
    optional ::TRP::SearchKeysRequest, :search_keys_request, 18
    optional ::TRP::SearchKeysResponse, :search_keys_response, 19
    optional ::TRP::CounterGroupInfoRequest, :counter_group_info_request, 20
    optional ::TRP::CounterGroupInfoResponse, :counter_group_info_response, 21
    optional ::TRP::SessionItemRequest, :session_item_request, 22
    optional ::TRP::SessionItemResponse, :session_item_response, 23
    optional ::TRP::BulkCounterItemRequest, :bulk_counter_item_request, 24
    optional ::TRP::BulkCounterItemResponse, :bulk_counter_item_response, 25
    optional ::TRP::TopperSnapshotRequest, :topper_snapshot_request, 28
    optional ::TRP::TopperSnapshotResponse, :topper_snapshot_response, 29
    optional ::TRP::UpdateKeyRequest, :update_key_request, 30
    optional ::TRP::KeySessionActivityRequest, :key_session_activity_request, 31
    optional ::TRP::KeySessionActivityResponse, :key_session_activity_response, 32
    optional ::TRP::SessionTrackerRequest, :session_tracker_request, 33
    optional ::TRP::SessionTrackerResponse, :session_tracker_response, 34
    optional ::TRP::ServerStatsRequest, :server_stats_request, 37
    optional ::TRP::ServerStatsResponse, :server_stats_response, 38
    optional ::TRP::SessionGroupRequest, :session_group_request, 39
    optional ::TRP::SessionGroupResponse, :session_group_response, 40
    optional ::TRP::AlertItemRequest, :alert_item_request, 41
    optional ::TRP::AlertItemResponse, :alert_item_response, 42
    optional ::TRP::AlertGroupRequest, :alert_group_request, 43
    optional ::TRP::AlertGroupResponse, :alert_group_response, 44
    optional ::TRP::ResourceItemRequest, :resource_item_request, 45
    optional ::TRP::ResourceItemResponse, :resource_item_response, 46
    optional ::TRP::ResourceGroupRequest, :resource_group_request, 47
    optional ::TRP::ResourceGroupResponse, :resource_group_response, 48
    optional ::TRP::KeyLookupRequest, :key_lookup_request, 49
    optional ::TRP::KeyLookupResponse, :key_lookup_response, 50
    optional ::TRP::GrepRequest, :grep_request, 51
    optional ::TRP::GrepResponse, :grep_response, 52

    gen_methods! # new fields ignored after this point
  end

  class HelloRequest < ::ProtocolBuffers::Message
    required :string, :station_id, 1

    gen_methods! # new fields ignored after this point
  end

  class HelloResponse < ::ProtocolBuffers::Message
    required :string, :trisul_id, 1
    required :string, :trisul_description, 2
    required :string, :connection_id, 3
    required :string, :version_string, 4
    required ::TRP::Timestamp, :connection_start_time, 5
    required ::TRP::Timestamp, :connection_up_time, 6
    required ::TRP::AuthLevel, :current_auth_level, 7

    gen_methods! # new fields ignored after this point
  end

  class ErrorResponse < ::ProtocolBuffers::Message
    required :int64, :original_command, 1
    required :int64, :error_code, 2
    required :string, :error_message, 3

    gen_methods! # new fields ignored after this point
  end

  class OKResponse < ::ProtocolBuffers::Message
    required :int64, :original_command, 1
    optional :string, :message, 2

    gen_methods! # new fields ignored after this point
  end

  class ReleaseContextRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1

    gen_methods! # new fields ignored after this point
  end

  class CounterItemRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    optional :int64, :meter, 3
    required :string, :key, 4
    required ::TRP::TimeInterval, :time_interval, 5
    optional :int64, :volumes_only, 6, :default => 0

    gen_methods! # new fields ignored after this point
  end

  class CounterItemResponse < ::ProtocolBuffers::Message
    required ::TRP::KeyStats, :stats, 1

    gen_methods! # new fields ignored after this point
  end

  class BulkCounterItemRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    required :int64, :meter, 3
    required ::TRP::TimeInterval, :time_interval, 4
    repeated :string, :keys, 5

    gen_methods! # new fields ignored after this point
  end

  class BulkCounterItemResponse < ::ProtocolBuffers::Message
    repeated ::TRP::KeyStats, :stats, 1

    gen_methods! # new fields ignored after this point
  end

  class CounterGroupRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    optional :int64, :meter, 3, :default => 0
    optional :int64, :maxitems, 4, :default => 10
    optional ::TRP::TimeInterval, :time_interval, 5
    optional ::TRP::Timestamp, :time_instant, 6
    optional :int64, :flags, 7

    gen_methods! # new fields ignored after this point
  end

  class CounterGroupResponse < ::ProtocolBuffers::Message
    required :int64, :context, 1
    required :string, :counter_group, 2
    required :int64, :meter, 3
    repeated ::TRP::KeyDetails, :keys, 6

    gen_methods! # new fields ignored after this point
  end

  class FilteredDatagramRequest < ::ProtocolBuffers::Message
    # forward declarations
    class ByFilterExpr < ::ProtocolBuffers::Message; end
    class BySession < ::ProtocolBuffers::Message; end
    class ByAlert < ::ProtocolBuffers::Message; end
    class ByResource < ::ProtocolBuffers::Message; end

    # nested messages
    class ByFilterExpr < ::ProtocolBuffers::Message
      required ::TRP::TimeInterval, :time_interval, 1
      required :string, :filter_expression, 2

      gen_methods! # new fields ignored after this point
    end

    class BySession < ::ProtocolBuffers::Message
      optional :string, :session_group, 1, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
      required ::TRP::SessionID, :session_id, 2

      gen_methods! # new fields ignored after this point
    end

    class ByAlert < ::ProtocolBuffers::Message
      optional :string, :alert_group, 1, :default => "{9AFD8C08-07EB-47E0-BF05-28B4A7AE8DC9}"
      required ::TRP::AlertID, :alert_id, 2

      gen_methods! # new fields ignored after this point
    end

    class ByResource < ::ProtocolBuffers::Message
      required :string, :resource_group, 1
      required ::TRP::ResourceID, :resource_id, 2

      gen_methods! # new fields ignored after this point
    end

    optional :int64, :max_packets, 1, :default => 0
    optional :int64, :max_bytes, 2, :default => 0
    optional ::TRP::CompressionType, :compress_type, 3, :default => ::TRP::CompressionType::UNCOMPRESSED
    optional ::TRP::FilteredDatagramRequest::ByFilterExpr, :filter_expression, 4
    optional ::TRP::FilteredDatagramRequest::BySession, :session, 5
    optional ::TRP::FilteredDatagramRequest::ByAlert, :alert, 6
    optional ::TRP::FilteredDatagramRequest::ByResource, :resource, 7

    gen_methods! # new fields ignored after this point
  end

  class FilteredDatagramResponse < ::ProtocolBuffers::Message
    required ::TRP::PcapFormat, :format, 1
    required ::TRP::CompressionType, :compress_type, 2
    required ::TRP::TimeInterval, :time_interval, 3
    required :int64, :num_datagrams, 4
    required :int64, :num_bytes, 5
    required :string, :sha1, 6
    required :bytes, :contents, 7

    gen_methods! # new fields ignored after this point
  end

  class ControlledContextRequest < ::ProtocolBuffers::Message
    required ::TRP::TimeInterval, :time_interval, 1
    required :string, :filter_expression, 2

    gen_methods! # new fields ignored after this point
  end

  class ControlledContextResponse < ::ProtocolBuffers::Message
    required :int64, :context, 1
    optional :string, :context_db, 2
    required ::TRP::TimeInterval, :time_interval, 3

    gen_methods! # new fields ignored after this point
  end

  class SearchKeysRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    required :string, :pattern, 3
    required :int64, :maxitems, 4

    gen_methods! # new fields ignored after this point
  end

  class SearchKeysResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :counter_group, 2
    repeated ::TRP::KeyDetails, :found_keys, 3

    gen_methods! # new fields ignored after this point
  end

  class CounterGroupInfoRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    optional :string, :counter_group, 2

    gen_methods! # new fields ignored after this point
  end

  class CounterGroupInfoResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    repeated ::TRP::CounterGroupDetails, :group_details, 2

    gen_methods! # new fields ignored after this point
  end

  class SessionItemRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    repeated :string, :session_keys, 3
    repeated ::TRP::SessionID, :session_ids, 4

    gen_methods! # new fields ignored after this point
  end

  class SessionItemResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Item < ::ProtocolBuffers::Message; end

    # nested messages
    class Item < ::ProtocolBuffers::Message
      optional :string, :session_key, 1
      optional ::TRP::SessionID, :session_id, 2
      optional :string, :user_label, 3
      required ::TRP::TimeInterval, :time_interval, 4
      required :int64, :state, 5
      required :int64, :az_bytes, 6
      required :int64, :za_bytes, 7
      required ::TRP::KeyDetails, :key1A, 8
      required ::TRP::KeyDetails, :key2A, 9
      required ::TRP::KeyDetails, :key1Z, 10
      required ::TRP::KeyDetails, :key2Z, 11

      gen_methods! # new fields ignored after this point
    end

    optional :int64, :context, 1, :default => 0
    required :string, :session_group, 2
    repeated ::TRP::SessionItemResponse::Item, :items, 3

    gen_methods! # new fields ignored after this point
  end

  class TopperSnapshotRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    required :int64, :meter, 3
    required ::TRP::TimeInterval, :Time, 4
    required :int64, :maxitems, 5

    gen_methods! # new fields ignored after this point
  end

  class TopperSnapshotResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :counter_group, 2
    required :int64, :meter, 3
    required ::TRP::Timestamp, :time, 4
    required :int64, :window_secs, 5
    required :string, :keys, 6
    required :string, :labels, 7

    gen_methods! # new fields ignored after this point
  end

  class UpdateKeyRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    required :string, :key, 4
    required :string, :label, 5
    optional :string, :description, 6

    gen_methods! # new fields ignored after this point
  end

  class KeySessionActivityRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    required :string, :key, 3
    optional :string, :key2, 4
    optional :int64, :maxitems, 5, :default => 100
    optional :int64, :volume_filter, 6, :default => 0
    optional :int64, :duration_filter, 7, :default => 0
    required ::TRP::TimeInterval, :time_interval, 8

    gen_methods! # new fields ignored after this point
  end

  class KeySessionActivityResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :session_group, 2
    repeated ::TRP::SessionID, :sessions, 3

    gen_methods! # new fields ignored after this point
  end

  class SessionTrackerRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    required :int64, :tracker_id, 3, :default => 1
    optional :int64, :maxitems, 4, :default => 100
    required ::TRP::TimeInterval, :time_interval, 5

    gen_methods! # new fields ignored after this point
  end

  class SessionTrackerResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :session_group, 2
    repeated ::TRP::SessionID, :sessions, 3

    gen_methods! # new fields ignored after this point
  end

  class SessionGroupRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    optional :int64, :tracker_id, 3
    optional :string, :key_filter, 4
    optional :int64, :maxitems, 5, :default => 100

    gen_methods! # new fields ignored after this point
  end

  class SessionGroupResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :session_group, 2
    repeated :string, :session_keys, 3

    gen_methods! # new fields ignored after this point
  end

  class ServerStatsRequest < ::ProtocolBuffers::Message
    required :int64, :param, 1

    gen_methods! # new fields ignored after this point
  end

  class ServerStatsResponse < ::ProtocolBuffers::Message
    required :string, :instance_name, 1
    required :int64, :connections, 2
    required :int64, :uptime_seconds, 3
    required :double, :cpu_usage_percent_trisul, 4
    required :double, :cpu_usage_percent_total, 5
    required :double, :mem_usage_trisul, 6
    required :double, :mem_usage_total, 7
    required :double, :mem_total, 8
    required :int64, :size_total, 9
    required :double, :drop_percent_cap, 11
    required :double, :drop_percent_trisul, 12
    required ::TRP::TimeInterval, :time_interval, 13

    gen_methods! # new fields ignored after this point
  end

  class AlertItemRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :alert_group, 2
    repeated ::TRP::AlertID, :alert_ids, 3

    gen_methods! # new fields ignored after this point
  end

  class AlertItemResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Item < ::ProtocolBuffers::Message; end

    # nested messages
    class Item < ::ProtocolBuffers::Message
      optional :int64, :sensor_id, 1
      required ::TRP::Timestamp, :time, 2
      required ::TRP::AlertID, :alert_id, 3
      optional :string, :source_ip, 4
      optional :string, :source_port, 5
      optional :string, :destination_ip, 6
      optional :string, :destination_port, 7
      required :string, :sigid, 8
      required :string, :classification, 9
      required :string, :priority, 10
      required ::TRP::Timestamp, :dispatch_time, 11
      required :string, :aux_message1, 12
      required :string, :aux_message2, 13

      gen_methods! # new fields ignored after this point
    end

    optional :int64, :context, 1
    required :string, :alert_group, 2
    repeated ::TRP::AlertItemResponse::Item, :items, 3

    gen_methods! # new fields ignored after this point
  end

  class AlertGroupRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :alert_group, 2
    required ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 5, :default => 10
    optional :string, :source_ip, 6
    optional :string, :source_port, 7
    optional :string, :destination_ip, 8
    optional :string, :destination_port, 9
    optional :string, :sigid, 10
    optional :string, :classification, 11
    optional :string, :priority, 12
    optional :string, :aux_message1, 13
    optional :string, :aux_message2, 14

    gen_methods! # new fields ignored after this point
  end

  class AlertGroupResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :alert_group, 2
    repeated ::TRP::AlertID, :alerts, 3

    gen_methods! # new fields ignored after this point
  end

  class ResourceItemRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :resource_group, 2
    repeated ::TRP::ResourceID, :resource_ids, 3

    gen_methods! # new fields ignored after this point
  end

  class ResourceItemResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Item < ::ProtocolBuffers::Message; end

    # nested messages
    class Item < ::ProtocolBuffers::Message
      required ::TRP::Timestamp, :time, 1
      required ::TRP::ResourceID, :resource_id, 2
      optional :string, :source_ip, 3
      optional :string, :source_port, 4
      optional :string, :destination_ip, 5
      optional :string, :destination_port, 6
      optional :string, :uri, 7
      optional :string, :userlabel, 8

      gen_methods! # new fields ignored after this point
    end

    optional :int64, :context, 1
    required :string, :resource_group, 2
    repeated ::TRP::ResourceItemResponse::Item, :items, 3

    gen_methods! # new fields ignored after this point
  end

  class ResourceGroupRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :resource_group, 2
    required ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 4, :default => 10
    optional :string, :source_ip, 5
    optional :string, :source_port, 6
    optional :string, :destination_ip, 7
    optional :string, :destination_port, 8
    optional :string, :uri_pattern, 9
    optional :string, :userlabel_pattern, 10

    gen_methods! # new fields ignored after this point
  end

  class ResourceGroupResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :resource_group, 2
    repeated ::TRP::ResourceID, :resources, 3

    gen_methods! # new fields ignored after this point
  end

  class KeyLookupRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    required :string, :counter_group, 2
    repeated :string, :keys, 3

    gen_methods! # new fields ignored after this point
  end

  class KeyLookupResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    required :string, :counter_group, 2
    repeated ::TRP::KeyDetails, :key_details, 3

    gen_methods! # new fields ignored after this point
  end

  class GrepRequest < ::ProtocolBuffers::Message
    optional :int64, :context, 1, :default => 0
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    required ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 4, :default => 50
    required :string, :pattern, 5

    gen_methods! # new fields ignored after this point
  end

  class GrepResponse < ::ProtocolBuffers::Message
    optional :int64, :context, 1
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    repeated ::TRP::SessionID, :sessions, 3

    gen_methods! # new fields ignored after this point
  end

end
