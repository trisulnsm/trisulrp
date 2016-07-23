#!/usr/bin/env ruby
# Generated by the protocol buffer compiler. DO NOT EDIT!

require 'protocol_buffers'

module TRP
  # forward declarations
  class Timestamp < ::ProtocolBuffers::Message; end
  class TimeInterval < ::ProtocolBuffers::Message; end
  class StatsTuple < ::ProtocolBuffers::Message; end
  class MeterValues < ::ProtocolBuffers::Message; end
  class MeterInfo < ::ProtocolBuffers::Message; end
  class KeyStats < ::ProtocolBuffers::Message; end
  class KeyT < ::ProtocolBuffers::Message; end
  class CounterGroupT < ::ProtocolBuffers::Message; end
  class SessionT < ::ProtocolBuffers::Message; end
  class AlertT < ::ProtocolBuffers::Message; end
  class ResourceT < ::ProtocolBuffers::Message; end
  class DocumentT < ::ProtocolBuffers::Message; end
  class NameValue < ::ProtocolBuffers::Message; end
  class Message < ::ProtocolBuffers::Message; end
  class HelloRequest < ::ProtocolBuffers::Message; end
  class HelloResponse < ::ProtocolBuffers::Message; end
  class ErrorResponse < ::ProtocolBuffers::Message; end
  class OKResponse < ::ProtocolBuffers::Message; end
  class CounterItemRequest < ::ProtocolBuffers::Message; end
  class CounterItemResponse < ::ProtocolBuffers::Message; end
  class CounterGroupTopperRequest < ::ProtocolBuffers::Message; end
  class CounterGroupTopperResponse < ::ProtocolBuffers::Message; end
  class SearchKeysRequest < ::ProtocolBuffers::Message; end
  class SearchKeysResponse < ::ProtocolBuffers::Message; end
  class CounterGroupInfoRequest < ::ProtocolBuffers::Message; end
  class CounterGroupInfoResponse < ::ProtocolBuffers::Message; end
  class QuerySessionsRequest < ::ProtocolBuffers::Message; end
  class QuerySessionsResponse < ::ProtocolBuffers::Message; end
  class UpdateKeyRequest < ::ProtocolBuffers::Message; end
  class SessionTrackerRequest < ::ProtocolBuffers::Message; end
  class SessionTrackerResponse < ::ProtocolBuffers::Message; end
  class QueryAlertsRequest < ::ProtocolBuffers::Message; end
  class QueryAlertsResponse < ::ProtocolBuffers::Message; end
  class QueryResourcesRequest < ::ProtocolBuffers::Message; end
  class QueryResourcesResponse < ::ProtocolBuffers::Message; end
  class KeySpaceRequest < ::ProtocolBuffers::Message; end
  class KeySpaceResponse < ::ProtocolBuffers::Message; end
  class TopperTrendRequest < ::ProtocolBuffers::Message; end
  class TopperTrendResponse < ::ProtocolBuffers::Message; end
  class SubscribeCtl < ::ProtocolBuffers::Message; end
  class QueryFTSRequest < ::ProtocolBuffers::Message; end
  class QueryFTSResponse < ::ProtocolBuffers::Message; end
  class TimeSlicesRequest < ::ProtocolBuffers::Message; end
  class PcapSlicesRequest < ::ProtocolBuffers::Message; end
  class TimeSlicesResponse < ::ProtocolBuffers::Message; end
  class DeleteAlertsRequest < ::ProtocolBuffers::Message; end
  class MetricsSummaryRequest < ::ProtocolBuffers::Message; end
  class MetricsSummaryResponse < ::ProtocolBuffers::Message; end
  class LogRequest < ::ProtocolBuffers::Message; end
  class LogResponse < ::ProtocolBuffers::Message; end
  class DomainRequest < ::ProtocolBuffers::Message; end
  class DomainResponse < ::ProtocolBuffers::Message; end
  class NodeConfigRequest < ::ProtocolBuffers::Message; end
  class NodeConfigResponse < ::ProtocolBuffers::Message; end
  class ContextCreateRequest < ::ProtocolBuffers::Message; end
  class ContextInfoRequest < ::ProtocolBuffers::Message; end
  class ContextInfoResponse < ::ProtocolBuffers::Message; end
  class ContextDeleteRequest < ::ProtocolBuffers::Message; end
  class ContextStartRequest < ::ProtocolBuffers::Message; end
  class ContextStopRequest < ::ProtocolBuffers::Message; end
  class ContextConfigRequest < ::ProtocolBuffers::Message; end
  class ContextConfigResponse < ::ProtocolBuffers::Message; end
  class PcapRequest < ::ProtocolBuffers::Message; end
  class PcapResponse < ::ProtocolBuffers::Message; end
  class GrepRequest < ::ProtocolBuffers::Message; end
  class GrepResponse < ::ProtocolBuffers::Message; end
  class ProbeStatsRequest < ::ProtocolBuffers::Message; end
  class ProbeStatsResponse < ::ProtocolBuffers::Message; end
  class AsyncResponse < ::ProtocolBuffers::Message; end
  class AsyncRequest < ::ProtocolBuffers::Message; end
  class FileRequest < ::ProtocolBuffers::Message; end
  class FileResponse < ::ProtocolBuffers::Message; end

  # enums
  module AuthLevel
    include ::ProtocolBuffers::Enum

    set_fully_qualified_name "TRP.AuthLevel"

    ADMIN = 1
    BASIC_USER = 2
    FORENSIC_USER = 3
    BLOCKED_USER = 4
  end

  module CompressionType
    include ::ProtocolBuffers::Enum

    set_fully_qualified_name "TRP.CompressionType"

    UNCOMPRESSED = 1
    GZIP = 2
  end

  module PcapFormat
    include ::ProtocolBuffers::Enum

    set_fully_qualified_name "TRP.PcapFormat"

    LIBPCAP = 1
    UNSNIFF = 2
  end

  module DomainNodeType
    include ::ProtocolBuffers::Enum

    set_fully_qualified_name "TRP.DomainNodeType"

    HUB = 0
    PROBE = 1
    CONFIG = 2
    ROUTER = 3
    WEB = 4
    MONITOR = 5
  end

  module DomainOperation
    include ::ProtocolBuffers::Enum

    set_fully_qualified_name "TRP.DomainOperation"

    GETNODES = 1
    HEARTBEAT = 2
    REGISTER = 3
  end

  class Timestamp < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.Timestamp"

    required :int64, :tv_sec, 1
    optional :int64, :tv_usec, 2, :default => 0
  end

  class TimeInterval < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.TimeInterval"

    required ::TRP::Timestamp, :from, 1
    required ::TRP::Timestamp, :to, 2
  end

  class StatsTuple < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.StatsTuple"

    required ::TRP::Timestamp, :ts, 1
    required :int64, :val, 2
  end

  class MeterValues < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.MeterValues"

    required :int32, :meter, 1
    repeated ::TRP::StatsTuple, :values, 2
    optional :int64, :total, 3
    optional :int64, :seconds, 4
  end

  class MeterInfo < ::ProtocolBuffers::Message
    # forward declarations

    # enums
    module MeterType
      include ::ProtocolBuffers::Enum

      set_fully_qualified_name "TRP.MeterInfo.MeterType"

      VT_INVALID = 0
      VT_RATE_COUNTER_WITH_SLIDING_WINDOW = 1
      VT_COUNTER = 2
      VT_COUNTER_WITH_SLIDING_WINDOW = 3
      VT_RATE_COUNTER = 4
      VT_GAUGE = 5
      VT_GAUGE_MIN_MAX_AVG = 6
      VT_AUTO = 7
      VT_RUNNING_COUNTER = 8
      VT_AVERAGE = 9
    end

    set_fully_qualified_name "TRP.MeterInfo"

    required :int32, :id, 1
    required ::TRP::MeterInfo::MeterType, :type, 2
    required :int32, :topcount, 3
    required :string, :name, 4
    optional :string, :description, 5
    optional :string, :units, 6
  end

  class KeyStats < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.KeyStats"

    required :string, :counter_group, 2
    required ::TRP::KeyT, :key, 3
    repeated ::TRP::MeterValues, :meters, 4
  end

  class KeyT < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.KeyT"

    optional :string, :key, 1
    optional :string, :readable, 2
    optional :string, :label, 3
    optional :string, :description, 4
    optional :int64, :metric, 5
  end

  class CounterGroupT < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterGroupT"

    required :string, :guid, 1
    required :string, :name, 2
    optional :int64, :bucket_size, 3
    optional ::TRP::TimeInterval, :time_interval, 4
    optional :int64, :topper_bucket_size, 5
    repeated ::TRP::MeterInfo, :meters, 6
  end

  class SessionT < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.SessionT"

    optional :string, :session_key, 1
    required :string, :session_id, 2
    optional :string, :user_label, 3
    required ::TRP::TimeInterval, :time_interval, 4
    optional :int64, :state, 5
    optional :int64, :az_bytes, 6
    optional :int64, :za_bytes, 7
    optional :int64, :az_packets, 8
    optional :int64, :za_packets, 9
    required ::TRP::KeyT, :key1A, 10
    required ::TRP::KeyT, :key2A, 11
    required ::TRP::KeyT, :key1Z, 12
    required ::TRP::KeyT, :key2Z, 13
    required ::TRP::KeyT, :protocol, 14
    optional ::TRP::KeyT, :nf_routerid, 15
    optional ::TRP::KeyT, :nf_ifindex_in, 16
    optional ::TRP::KeyT, :nf_ifindex_out, 17
    optional :string, :tags, 18
    optional :int64, :az_payload, 19
    optional :int64, :za_payload, 20
    optional :int64, :setup_rtt, 21
    optional :int64, :retransmissions, 22
    optional :int64, :tracker_statval, 23
    optional :string, :probe_id, 24
  end

  class AlertT < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.AlertT"

    optional :int64, :sensor_id, 1
    required ::TRP::Timestamp, :time, 2
    required :string, :alert_id, 3
    optional ::TRP::KeyT, :source_ip, 4
    optional ::TRP::KeyT, :source_port, 5
    optional ::TRP::KeyT, :destination_ip, 6
    optional ::TRP::KeyT, :destination_port, 7
    optional ::TRP::KeyT, :sigid, 8
    optional ::TRP::KeyT, :classification, 9
    optional ::TRP::KeyT, :priority, 10
    optional ::TRP::Timestamp, :dispatch_time, 11
    optional :string, :aux_message1, 12
    optional :string, :aux_message2, 13
    optional :int64, :occurrances, 14, :default => 1
    optional :string, :group_by_key, 15
    optional :string, :probe_id, 16
  end

  class ResourceT < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ResourceT"

    required ::TRP::Timestamp, :time, 1
    required :string, :resource_id, 2
    optional ::TRP::KeyT, :source_ip, 3
    optional ::TRP::KeyT, :source_port, 4
    optional ::TRP::KeyT, :destination_ip, 5
    optional ::TRP::KeyT, :destination_port, 6
    optional :string, :uri, 7
    optional :string, :userlabel, 8
    optional :string, :probe_id, 9
  end

  class DocumentT < ::ProtocolBuffers::Message
    # forward declarations
    class Flow < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.DocumentT"

    # nested messages
    class Flow < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.DocumentT.Flow"

      required ::TRP::Timestamp, :time, 1
      required :string, :key, 2
    end

    required :string, :dockey, 1
    optional :string, :fts_attributes, 2
    optional :string, :fullcontent, 3
    repeated ::TRP::DocumentT::Flow, :flows, 4
    optional :string, :probe_id, 5
  end

  class NameValue < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.NameValue"

    required :string, :name, 1
    optional :string, :value, 2
  end

  class Message < ::ProtocolBuffers::Message
    # forward declarations

    # enums
    module Command
      include ::ProtocolBuffers::Enum

      set_fully_qualified_name "TRP.Message.Command"

      HELLO_REQUEST = 1
      HELLO_RESPONSE = 2
      OK_RESPONSE = 3
      ERROR_RESPONSE = 5
      COUNTER_GROUP_TOPPER_REQUEST = 6
      COUNTER_GROUP_TOPPER_RESPONSE = 7
      COUNTER_ITEM_REQUEST = 8
      COUNTER_ITEM_RESPONSE = 9
      PCAP_REQUEST = 14
      PCAP_RESPONSE = 15
      SEARCH_KEYS_REQUEST = 18
      SEARCH_KEYS_RESPONSE = 19
      COUNTER_GROUP_INFO_REQUEST = 20
      COUNTER_GROUP_INFO_RESPONSE = 21
      SESSION_TRACKER_REQUEST = 22
      SESSION_TRACKER_RESPONSE = 23
      UPDATE_KEY_REQUEST = 32
      UPDATE_KEY_RESPONSE = 33
      QUERY_SESSIONS_REQUEST = 34
      QUERY_SESSIONS_RESPONSE = 35
      PROBE_STATS_REQUEST = 38
      PROBE_STATS_RESPONSE = 39
      QUERY_ALERTS_REQUEST = 44
      QUERY_ALERTS_RESPONSE = 45
      QUERY_RESOURCES_REQUEST = 48
      QUERY_RESOURCES_RESPONSE = 49
      GREP_REQUEST = 60
      GREP_RESPONSE = 61
      KEYSPACE_REQUEST = 70
      KEYSPACE_RESPONSE = 71
      TOPPER_TREND_REQUEST = 72
      TOPPER_TREND_RESPONSE = 73
      STAB_PUBSUB_CTL = 80
      QUERY_FTS_REQUEST = 90
      QUERY_FTS_RESPONSE = 91
      TIMESLICES_REQUEST = 92
      TIMESLICES_RESPONSE = 93
      DELETE_ALERTS_REQUEST = 94
      METRICS_SUMMARY_REQUEST = 95
      METRICS_SUMMARY_RESPONSE = 96
      PCAP_SLICES_REQUEST = 97
      SERVICE_REQUEST = 101
      SERVICE_RESPONSE = 102
      CONFIG_REQUEST = 103
      CONFIG_RESPONSE = 104
      LOG_REQUEST = 105
      LOG_RESPONSE = 106
      CONTEXT_CREATE_REQUEST = 108
      CONTEXT_DELETE_REQUEST = 109
      CONTEXT_START_REQUEST = 110
      CONTEXT_STOP_REQUEST = 111
      CONTEXT_INFO_REQUEST = 112
      CONTEXT_INFO_RESPONSE = 113
      CONTEXT_CONFIG_REQUEST = 114
      CONTEXT_CONFIG_RESPONSE = 115
      DOMAIN_REQUEST = 116
      DOMAIN_RESPONSE = 117
      NODE_CONFIG_REQUEST = 118
      NODE_CONFIG_RESPONSE = 119
      ASYNC_REQUEST = 120
      ASYNC_RESPONSE = 121
      FILE_REQUEST = 122
      FILE_RESPONSE = 123
      SUBSYSTEM_INIT = 124
      SUBSYSTEM_EXIT = 125
    end

    set_fully_qualified_name "TRP.Message"

    required ::TRP::Message::Command, :trp_command, 1
    optional ::TRP::HelloRequest, :hello_request, 2
    optional ::TRP::HelloResponse, :hello_response, 3
    optional ::TRP::OKResponse, :ok_response, 4
    optional ::TRP::ErrorResponse, :error_response, 5
    optional ::TRP::CounterGroupTopperRequest, :counter_group_topper_request, 6
    optional ::TRP::CounterGroupTopperResponse, :counter_group_topper_response, 7
    optional ::TRP::CounterItemRequest, :counter_item_request, 8
    optional ::TRP::CounterItemResponse, :counter_item_response, 9
    optional ::TRP::PcapRequest, :pcap_request, 14
    optional ::TRP::PcapResponse, :pcap_response, 15
    optional ::TRP::SearchKeysRequest, :search_keys_request, 18
    optional ::TRP::SearchKeysResponse, :search_keys_response, 19
    optional ::TRP::CounterGroupInfoRequest, :counter_group_info_request, 20
    optional ::TRP::CounterGroupInfoResponse, :counter_group_info_response, 21
    optional ::TRP::UpdateKeyRequest, :update_key_request, 30
    optional ::TRP::QuerySessionsRequest, :query_sessions_request, 31
    optional ::TRP::QuerySessionsResponse, :query_sessions_response, 32
    optional ::TRP::SessionTrackerRequest, :session_tracker_request, 33
    optional ::TRP::SessionTrackerResponse, :session_tracker_response, 34
    optional ::TRP::ProbeStatsRequest, :probe_stats_request, 37
    optional ::TRP::ProbeStatsResponse, :probe_stats_response, 38
    optional ::TRP::QueryAlertsRequest, :query_alerts_request, 43
    optional ::TRP::QueryAlertsResponse, :query_alerts_response, 44
    optional ::TRP::QueryResourcesRequest, :query_resources_request, 47
    optional ::TRP::QueryResourcesResponse, :query_resources_response, 48
    optional ::TRP::GrepRequest, :grep_request, 51
    optional ::TRP::GrepResponse, :grep_response, 52
    optional ::TRP::TopperTrendRequest, :topper_trend_request, 55
    optional ::TRP::TopperTrendResponse, :topper_trend_response, 56
    optional ::TRP::SubscribeCtl, :subscribe_ctl, 59
    optional ::TRP::QueryFTSRequest, :query_fts_request, 60
    optional ::TRP::QueryFTSResponse, :query_fts_response, 61
    optional ::TRP::TimeSlicesRequest, :time_slices_request, 62
    optional ::TRP::TimeSlicesResponse, :time_slices_response, 63
    optional ::TRP::DeleteAlertsRequest, :delete_alerts_request, 64
    optional ::TRP::MetricsSummaryRequest, :metrics_summary_request, 65
    optional ::TRP::MetricsSummaryResponse, :metrics_summary_response, 66
    optional ::TRP::KeySpaceRequest, :key_space_request, 67
    optional ::TRP::KeySpaceResponse, :key_space_response, 68
    optional ::TRP::PcapSlicesRequest, :pcap_slices_request, 69
    optional ::TRP::LogRequest, :log_request, 105
    optional ::TRP::LogResponse, :log_response, 106
    optional ::TRP::ContextCreateRequest, :context_create_request, 108
    optional ::TRP::ContextDeleteRequest, :context_delete_request, 109
    optional ::TRP::ContextStartRequest, :context_start_request, 110
    optional ::TRP::ContextStopRequest, :context_stop_request, 111
    optional ::TRP::ContextConfigRequest, :context_config_request, 112
    optional ::TRP::ContextConfigResponse, :context_config_response, 113
    optional ::TRP::ContextInfoRequest, :context_info_request, 114
    optional ::TRP::ContextInfoResponse, :context_info_response, 115
    optional ::TRP::DomainRequest, :domain_request, 116
    optional ::TRP::DomainResponse, :domain_response, 117
    optional ::TRP::NodeConfigRequest, :node_config_request, 118
    optional ::TRP::NodeConfigResponse, :node_config_response, 119
    optional ::TRP::AsyncRequest, :async_request, 120
    optional ::TRP::AsyncResponse, :async_response, 121
    optional ::TRP::FileRequest, :file_request, 122
    optional ::TRP::FileResponse, :file_response, 123
    optional :string, :destination_node, 200
    optional :string, :probe_id, 201
    optional :bool, :run_async, 202
  end

  class HelloRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.HelloRequest"

    required :string, :station_id, 1
    optional :string, :message, 2
  end

  class HelloResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.HelloResponse"

    required :string, :station_id, 1
    optional :string, :station_id_request, 2
    optional :string, :message, 3
  end

  class ErrorResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ErrorResponse"

    required :int64, :original_command, 1
    required :int64, :error_code, 2
    required :string, :error_message, 3
  end

  class OKResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.OKResponse"

    required :int64, :original_command, 1
    optional :string, :message, 2
  end

  class CounterItemRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterItemRequest"

    required :string, :counter_group, 2
    optional :int64, :meter, 3
    required ::TRP::KeyT, :key, 4
    required ::TRP::TimeInterval, :time_interval, 5
    optional :int64, :volumes_only, 6, :default => 0
  end

  class CounterItemResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterItemResponse"

    required ::TRP::KeyStats, :stats, 1
  end

  class CounterGroupTopperRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterGroupTopperRequest"

    required :string, :counter_group, 2
    optional :int64, :meter, 3, :default => 0
    optional :int64, :maxitems, 4, :default => 100
    optional ::TRP::TimeInterval, :time_interval, 5
    optional ::TRP::Timestamp, :time_instant, 6
    optional :int64, :flags, 7
    optional :bool, :resolve_keys, 8, :default => true
  end

  class CounterGroupTopperResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterGroupTopperResponse"

    required :string, :counter_group, 2
    required :int64, :meter, 3
    optional :int64, :sysgrouptotal, 4
    repeated ::TRP::KeyT, :keys, 6
  end

  class SearchKeysRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.SearchKeysRequest"

    required :string, :counter_group, 2
    optional :int64, :maxitems, 3, :default => 100
    optional :string, :pattern, 4
    optional :string, :label, 5
    repeated :string, :keys, 6
    optional :int64, :offset, 7, :default => 0
    optional :bool, :get_totals, 8, :default => false
  end

  class SearchKeysResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.SearchKeysResponse"

    required :string, :counter_group, 2
    repeated ::TRP::KeyT, :keys, 3
    optional :int64, :total_count, 4
  end

  class CounterGroupInfoRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterGroupInfoRequest"

    optional :string, :counter_group, 2
    optional :bool, :get_meter_info, 3, :default => false
  end

  class CounterGroupInfoResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.CounterGroupInfoResponse"

    repeated ::TRP::CounterGroupT, :group_details, 2
  end

  class QuerySessionsRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QuerySessionsRequest"

    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    optional ::TRP::TimeInterval, :time_interval, 3
    optional :string, :key, 4
    optional ::TRP::KeyT, :source_ip, 5
    optional ::TRP::KeyT, :source_port, 6
    optional ::TRP::KeyT, :dest_ip, 7
    optional ::TRP::KeyT, :dest_port, 8
    optional ::TRP::KeyT, :any_ip, 9
    optional ::TRP::KeyT, :any_port, 10
    repeated ::TRP::KeyT, :ip_pair, 11
    optional ::TRP::KeyT, :protocol, 12
    optional :string, :flowtag, 13
    optional ::TRP::KeyT, :nf_routerid, 14
    optional ::TRP::KeyT, :nf_ifindex_in, 15
    optional ::TRP::KeyT, :nf_ifindex_out, 16
    optional :string, :subnet_24, 17
    optional :string, :subnet_16, 18
    optional :int64, :maxitems, 19, :default => 100
    optional :int64, :volume_filter, 20, :default => 0
    optional :bool, :resolve_keys, 21, :default => true
    optional :string, :outputpath, 22
    repeated :string, :idlist, 23
  end

  class QuerySessionsResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QuerySessionsResponse"

    required :string, :session_group, 2
    repeated ::TRP::SessionT, :sessions, 3
    optional :string, :outputpath, 4
  end

  class UpdateKeyRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.UpdateKeyRequest"

    required :string, :counter_group, 2
    repeated ::TRP::KeyT, :keys, 4
  end

  class SessionTrackerRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.SessionTrackerRequest"

    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    required :int64, :tracker_id, 3, :default => 1
    optional :int64, :maxitems, 4, :default => 100
    required ::TRP::TimeInterval, :time_interval, 5
    optional :bool, :resolve_keys, 6, :default => true
  end

  class SessionTrackerResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.SessionTrackerResponse"

    required :string, :session_group, 2
    repeated ::TRP::SessionT, :sessions, 3
    optional :int64, :tracker_id, 4
  end

  class QueryAlertsRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QueryAlertsRequest"

    required :string, :alert_group, 2
    optional ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 5, :default => 100
    optional ::TRP::KeyT, :source_ip, 6
    optional ::TRP::KeyT, :source_port, 7
    optional ::TRP::KeyT, :destination_ip, 8
    optional ::TRP::KeyT, :destination_port, 9
    optional ::TRP::KeyT, :sigid, 10
    optional ::TRP::KeyT, :classification, 11
    optional ::TRP::KeyT, :priority, 12
    optional :string, :aux_message1, 13
    optional :string, :aux_message2, 14
    optional :string, :group_by_fieldname, 15
    repeated :string, :idlist, 16
    optional :bool, :resolve_keys, 17, :default => true
    optional ::TRP::KeyT, :any_ip, 18
    optional ::TRP::KeyT, :any_port, 19
    repeated ::TRP::KeyT, :ip_pair, 20
    optional :string, :message_regex, 21
  end

  class QueryAlertsResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QueryAlertsResponse"

    required :string, :alert_group, 2
    repeated ::TRP::AlertT, :alerts, 3
  end

  class QueryResourcesRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QueryResourcesRequest"

    required :string, :resource_group, 2
    optional ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 4, :default => 100
    optional ::TRP::KeyT, :source_ip, 5
    optional ::TRP::KeyT, :source_port, 6
    optional ::TRP::KeyT, :destination_ip, 7
    optional ::TRP::KeyT, :destination_port, 8
    optional :string, :uri_pattern, 9
    optional :string, :userlabel_pattern, 10
    repeated :string, :regex_uri, 12
    repeated :string, :idlist, 13
    optional :bool, :resolve_keys, 14, :default => true
    optional ::TRP::KeyT, :any_port, 15
    optional ::TRP::KeyT, :any_ip, 16
    repeated ::TRP::KeyT, :ip_pair, 17
  end

  class QueryResourcesResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QueryResourcesResponse"

    required :string, :resource_group, 2
    repeated ::TRP::ResourceT, :resources, 3
  end

  class KeySpaceRequest < ::ProtocolBuffers::Message
    # forward declarations
    class KeySpace < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.KeySpaceRequest"

    # nested messages
    class KeySpace < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.KeySpaceRequest.KeySpace"

      required ::TRP::KeyT, :from_key, 1
      required ::TRP::KeyT, :to_key, 2
    end

    required :string, :counter_group, 2
    required ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 4, :default => 100
    repeated ::TRP::KeySpaceRequest::KeySpace, :spaces, 5
    optional :bool, :resolve_keys, 6, :default => true
  end

  class KeySpaceResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.KeySpaceResponse"

    optional :string, :counter_group, 2
    repeated ::TRP::KeyT, :hits, 3
  end

  class TopperTrendRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.TopperTrendRequest"

    required :string, :counter_group, 2
    optional :int64, :meter, 3, :default => 0
    optional :int64, :maxitems, 4, :default => 100
    optional ::TRP::TimeInterval, :time_interval, 5
  end

  class TopperTrendResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.TopperTrendResponse"

    required :string, :counter_group, 2
    required :int64, :meter, 3
    repeated ::TRP::KeyStats, :keytrends, 4
  end

  class SubscribeCtl < ::ProtocolBuffers::Message
    # forward declarations

    # enums
    module StabberType
      include ::ProtocolBuffers::Enum

      set_fully_qualified_name "TRP.SubscribeCtl.StabberType"

      ST_COUNTER_ITEM = 0
      ST_ALERT = 1
      ST_FLOW = 2
      ST_TOPPER = 3
    end

    module CtlType
      include ::ProtocolBuffers::Enum

      set_fully_qualified_name "TRP.SubscribeCtl.CtlType"

      CT_SUBSCRIBE = 0
      CT_UNSUBSCRIBE = 1
    end

    set_fully_qualified_name "TRP.SubscribeCtl"

    required :string, :context_name, 1
    required ::TRP::SubscribeCtl::CtlType, :ctl, 2
    required ::TRP::SubscribeCtl::StabberType, :type, 3
    optional :string, :guid, 4
    optional :string, :key, 5
    optional :int64, :meterid, 6
  end

  class QueryFTSRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QueryFTSRequest"

    required ::TRP::TimeInterval, :time_interval, 2
    required :string, :fts_group, 3
    required :string, :keywords, 4
    optional :int64, :maxitems, 5, :default => 100
  end

  class QueryFTSResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.QueryFTSResponse"

    required :string, :fts_group, 2
    repeated ::TRP::DocumentT, :documents, 3
  end

  class TimeSlicesRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.TimeSlicesRequest"

    optional :bool, :get_disk_usage, 1, :default => false
    optional :bool, :get_all_engines, 2, :default => false
    optional :bool, :get_total_window, 3, :default => false
  end

  class PcapSlicesRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.PcapSlicesRequest"

    required :string, :context_name, 1
    optional :bool, :get_total_window, 2, :default => false
  end

  class TimeSlicesResponse < ::ProtocolBuffers::Message
    # forward declarations
    class SliceT < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.TimeSlicesResponse"

    # nested messages
    class SliceT < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.TimeSlicesResponse.SliceT"

      required ::TRP::TimeInterval, :time_interval, 1
      optional :string, :name, 2
      optional :string, :status, 3
      optional :int64, :disk_size, 4
      optional :string, :path, 5
      optional :bool, :available, 6
    end

    repeated ::TRP::TimeSlicesResponse::SliceT, :slices, 1
    optional ::TRP::TimeInterval, :total_window, 2
    optional :string, :context_name, 3
  end

  class DeleteAlertsRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.DeleteAlertsRequest"

    required :string, :alert_group, 2
    required ::TRP::TimeInterval, :time_interval, 3
    optional ::TRP::KeyT, :source_ip, 6
    optional ::TRP::KeyT, :source_port, 7
    optional ::TRP::KeyT, :destination_ip, 8
    optional ::TRP::KeyT, :destination_port, 9
    optional ::TRP::KeyT, :sigid, 10
    optional ::TRP::KeyT, :classification, 11
    optional ::TRP::KeyT, :priority, 12
    optional ::TRP::KeyT, :any_ip, 18
    optional ::TRP::KeyT, :any_port, 19
    optional :string, :message_regex, 21
  end

  class MetricsSummaryRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.MetricsSummaryRequest"

    optional ::TRP::TimeInterval, :time_interval, 1
    required :string, :metric_name, 2
    optional :bool, :totals_only, 3, :default => true
  end

  class MetricsSummaryResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.MetricsSummaryResponse"

    required :string, :metric_name, 2
    repeated ::TRP::StatsTuple, :vals, 3
  end

  class LogRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.LogRequest"

    required :string, :context_name, 1
    required :string, :log_type, 2
    optional :string, :regex_filter, 4
    optional :int64, :maxlines, 5, :default => 1000
    optional :string, :continue_logfilename, 6
    optional :int64, :continue_seekpos, 7
    optional :bool, :latest_run_only, 8, :default => false
  end

  class LogResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.LogResponse"

    required :string, :context_name, 1
    optional :string, :logfilename, 6
    optional :int64, :seekpos, 7
    repeated :string, :log_lines, 8
  end

  class DomainRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.DomainRequest"

    required ::TRP::DomainOperation, :cmd, 1
    optional :string, :station_id, 2
    optional :string, :params, 3
    optional ::TRP::DomainNodeType, :nodetype, 4
  end

  class DomainResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Node < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.DomainResponse"

    # nested messages
    class Node < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.DomainResponse.Node"

      required :string, :id, 1
      required ::TRP::DomainNodeType, :nodetype, 2
      optional :string, :station_id, 3
      optional :string, :extra_info, 4
      optional ::TRP::Timestamp, :register_time, 5
      optional ::TRP::Timestamp, :heartbeat_time, 6
    end

    required ::TRP::DomainOperation, :cmd, 1
    repeated ::TRP::DomainResponse::Node, :nodes, 2
    optional :string, :req_params, 3
    optional :string, :params, 4
    optional :bool, :need_reconnect, 5, :default => false
  end

  class NodeConfigRequest < ::ProtocolBuffers::Message
    # forward declarations
    class IntelFeed < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.NodeConfigRequest"

    # nested messages
    class IntelFeed < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.NodeConfigRequest.IntelFeed"

      required :string, :guid, 1
      optional :string, :name, 2
      optional :string, :download_rules, 3
      repeated :string, :uri, 4
    end

    optional :string, :message, 1
    optional ::TRP::NodeConfigRequest::IntelFeed, :add_feed, 2
    optional ::TRP::NodeConfigRequest::IntelFeed, :process_new_feed, 3
  end

  class NodeConfigResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Node < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.NodeConfigResponse"

    # nested messages
    class Node < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.NodeConfigResponse.Node"

      required :string, :id, 1
      required ::TRP::DomainNodeType, :nodetype, 2
      required :string, :description, 3
      required :string, :public_key, 4
    end

    repeated ::TRP::NodeConfigResponse::Node, :domains, 1
    repeated ::TRP::NodeConfigResponse::Node, :hubs, 2
    repeated ::TRP::NodeConfigResponse::Node, :probes, 3
    repeated :string, :feeds, 4
  end

  class ContextCreateRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ContextCreateRequest"

    required :string, :context_name, 1
    optional :string, :clone_from, 2
  end

  class ContextInfoRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ContextInfoRequest"

    optional :string, :context_name, 1
  end

  class ContextInfoResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Item < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.ContextInfoResponse"

    # nested messages
    class Item < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.ContextInfoResponse.Item"

      required :string, :context_name, 1
      required :bool, :is_initialized, 2
      required :bool, :is_running, 3
      optional :int64, :size_on_disk, 4
      optional ::TRP::TimeInterval, :time_interval, 5
      optional :bool, :is_clean, 6
      optional :string, :extrainfo, 7
      repeated ::TRP::TimeInterval, :run_history, 8
      optional :string, :profile, 9
      optional :string, :runmode, 10
    end

    repeated ::TRP::ContextInfoResponse::Item, :items, 1
  end

  class ContextDeleteRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ContextDeleteRequest"

    required :string, :context_name, 1
    optional :bool, :reset_data, 2
  end

  class ContextStartRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ContextStartRequest"

    required :string, :context_name, 1
    optional :string, :mode, 2
    optional :bool, :background, 3
    optional :string, :pcap_path, 4
    optional :string, :run_tool, 5
    optional :string, :tool_ids_config, 6
    optional :string, :tool_av_config, 7
  end

  class ContextStopRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ContextStopRequest"

    required :string, :context_name, 1
    optional :string, :run_tool, 5
  end

  class ContextConfigRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ContextConfigRequest"

    required :string, :context_name, 1
    optional :string, :profile, 2
    optional :string, :params, 3
    optional :bytes, :push_config_blob, 4
    optional :string, :query_config, 5
    repeated ::TRP::NameValue, :set_config_values, 6
  end

  class ContextConfigResponse < ::ProtocolBuffers::Message
    # forward declarations
    class Layer < ::ProtocolBuffers::Message; end

    set_fully_qualified_name "TRP.ContextConfigResponse"

    # nested messages
    class Layer < ::ProtocolBuffers::Message
      set_fully_qualified_name "TRP.ContextConfigResponse.Layer"

      required :int64, :layer, 1
      required :string, :probe_id, 2
      optional :string, :probe_description, 3
    end

    required :string, :context_name, 1
    optional :string, :profile, 2
    optional :string, :params, 3
    optional :bytes, :pull_config_blob, 4
    optional :bytes, :config_blob, 5
    repeated :string, :endpoints_flush, 6
    repeated :string, :endpoints_query, 7
    repeated :string, :endpoints_pub, 8
    optional :string, :config_value, 10
    repeated ::TRP::ContextConfigResponse::Layer, :layers, 11
  end

  class PcapRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.PcapRequest"

    required :string, :context_name, 1
    optional :int64, :max_bytes, 2, :default => 100000000
    optional ::TRP::CompressionType, :compress_type, 3, :default => ::TRP::CompressionType::UNCOMPRESSED
    optional :string, :save_file, 4
    required ::TRP::TimeInterval, :time_interval, 5
    required :string, :filter_expression, 6
  end

  class PcapResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.PcapResponse"

    required :string, :context_name, 1
    optional ::TRP::PcapFormat, :format, 2, :default => ::TRP::PcapFormat::LIBPCAP
    optional ::TRP::CompressionType, :compress_type, 3, :default => ::TRP::CompressionType::UNCOMPRESSED
    optional ::TRP::TimeInterval, :time_interval, 4
    optional :int64, :num_bytes, 5
    optional :string, :sha1, 6
    optional :bytes, :contents, 7
    optional :string, :save_file, 8
  end

  class GrepRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.GrepRequest"

    required :string, :context_name, 1
    required ::TRP::TimeInterval, :time_interval, 2
    optional :int64, :maxitems, 3, :default => 100
    optional :int64, :flowcutoff_bytes, 4
    optional :string, :pattern_hex, 5
    optional :string, :pattern_text, 6
    optional :string, :pattern_file, 7
    repeated :string, :md5list, 8
    optional :bool, :resolve_keys, 9, :default => true
  end

  class GrepResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.GrepResponse"

    required :string, :context_name, 1
    repeated ::TRP::SessionT, :sessions, 2
    repeated :string, :hints, 3
  end

  class ProbeStatsRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ProbeStatsRequest"

    required :string, :context_name, 1
    optional :string, :param, 2
  end

  class ProbeStatsResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.ProbeStatsResponse"

    required :string, :context_name, 1
    required :string, :instance_name, 2
    required :int64, :connections, 3
    required :int64, :uptime_seconds, 4
    required :double, :cpu_usage_percent_trisul, 5
    required :double, :cpu_usage_percent_total, 6
    required :double, :mem_usage_trisul, 7
    required :double, :mem_usage_total, 8
    required :double, :mem_total, 9
    required :double, :drop_percent_cap, 10
    required :double, :drop_percent_trisul, 11
    optional :int64, :proc_bytes, 12
    optional :int64, :proc_packets, 13
    optional :string, :offline_pcap_file, 14
    optional :bool, :is_running, 15
  end

  class AsyncResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.AsyncResponse"

    required :int64, :token, 1
    optional :string, :response_message, 3
    optional ::TRP::Message, :response, 4
  end

  class AsyncRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.AsyncRequest"

    required :int64, :token, 1
    optional :string, :request_message, 2
  end

  class FileRequest < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.FileRequest"

    required :string, :uri, 1
    required :int64, :position, 2
    optional :string, :params, 3
  end

  class FileResponse < ::ProtocolBuffers::Message
    set_fully_qualified_name "TRP.FileResponse"

    required :string, :uri, 1
    required :bool, :eof, 2
    optional :int64, :position, 3
    optional :bytes, :content, 4
    optional :string, :request_params, 5
  end

end
