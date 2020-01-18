# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module TRP
  ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

  ##
  # Enum Classes
  #
  class AuthLevel < ::Protobuf::Enum
    define :ADMIN, 1
    define :BASIC_USER, 2
    define :FORENSIC_USER, 3
    define :BLOCKED_USER, 4
  end

  class CompressionType < ::Protobuf::Enum
    define :UNCOMPRESSED, 1
    define :GZIP, 2
  end

  class PcapFormat < ::Protobuf::Enum
    define :LIBPCAP, 1
    define :UNSNIFF, 2
    define :LIBPCAPNOFILEHEADER, 3
  end

  class DomainNodeType < ::Protobuf::Enum
    define :HUB, 0
    define :PROBE, 1
    define :CONFIG, 2
    define :ROUTER, 3
    define :WEB, 4
    define :MONITOR, 5
  end

  class DomainOperation < ::Protobuf::Enum
    define :GETNODES, 1
    define :HEARTBEAT, 2
    define :REGISTER, 3
  end


  ##
  # Message Classes
  #
  class Timestamp < ::Protobuf::Message; end
  class TimeInterval < ::Protobuf::Message; end
  class StatsTuple < ::Protobuf::Message; end
  class StatsArray < ::Protobuf::Message; end
  class MeterValues < ::Protobuf::Message; end
  class MeterInfo < ::Protobuf::Message
    class MeterType < ::Protobuf::Enum
      define :VT_INVALID, 0
      define :VT_RATE_COUNTER_WITH_SLIDING_WINDOW, 1
      define :VT_COUNTER, 2
      define :VT_COUNTER_WITH_SLIDING_WINDOW, 3
      define :VT_RATE_COUNTER, 4
      define :VT_GAUGE, 5
      define :VT_GAUGE_MIN_MAX_AVG, 6
      define :VT_AUTO, 7
      define :VT_RUNNING_COUNTER, 8
      define :VT_AVERAGE, 9
      define :VT_DELTA_RATE_COUNTER, 10
      define :VT_MAX, 11
      define :VT_MIN, 12
    end

  end

  class KeyStats < ::Protobuf::Message; end
  class KeyT < ::Protobuf::Message
    class NameValueT < ::Protobuf::Message; end

  end

  class CounterGroupT < ::Protobuf::Message
    class Crosskey < ::Protobuf::Message; end

  end

  class SessionT < ::Protobuf::Message; end
  class AlertT < ::Protobuf::Message; end
  class ResourceT < ::Protobuf::Message; end
  class DocumentT < ::Protobuf::Message
    class Flow < ::Protobuf::Message; end

  end

  class VertexGroupT < ::Protobuf::Message; end
  class EdgeGraphT < ::Protobuf::Message; end
  class NameValue < ::Protobuf::Message; end
  class Message < ::Protobuf::Message
    class Command < ::Protobuf::Enum
      define :HELLO_REQUEST, 1
      define :HELLO_RESPONSE, 2
      define :OK_RESPONSE, 3
      define :ERROR_RESPONSE, 5
      define :COUNTER_GROUP_TOPPER_REQUEST, 6
      define :COUNTER_GROUP_TOPPER_RESPONSE, 7
      define :COUNTER_ITEM_REQUEST, 8
      define :COUNTER_ITEM_RESPONSE, 9
      define :PCAP_REQUEST, 14
      define :PCAP_RESPONSE, 15
      define :SEARCH_KEYS_REQUEST, 18
      define :SEARCH_KEYS_RESPONSE, 19
      define :COUNTER_GROUP_INFO_REQUEST, 20
      define :COUNTER_GROUP_INFO_RESPONSE, 21
      define :SESSION_TRACKER_REQUEST, 22
      define :SESSION_TRACKER_RESPONSE, 23
      define :UPDATE_KEY_REQUEST, 32
      define :UPDATE_KEY_RESPONSE, 33
      define :QUERY_SESSIONS_REQUEST, 34
      define :QUERY_SESSIONS_RESPONSE, 35
      define :PROBE_STATS_REQUEST, 38
      define :PROBE_STATS_RESPONSE, 39
      define :QUERY_ALERTS_REQUEST, 44
      define :QUERY_ALERTS_RESPONSE, 45
      define :QUERY_RESOURCES_REQUEST, 48
      define :QUERY_RESOURCES_RESPONSE, 49
      define :GREP_REQUEST, 60
      define :GREP_RESPONSE, 61
      define :KEYSPACE_REQUEST, 70
      define :KEYSPACE_RESPONSE, 71
      define :TOPPER_TREND_REQUEST, 72
      define :TOPPER_TREND_RESPONSE, 73
      define :STAB_PUBSUB_CTL, 80
      define :QUERY_FTS_REQUEST, 90
      define :QUERY_FTS_RESPONSE, 91
      define :TIMESLICES_REQUEST, 92
      define :TIMESLICES_RESPONSE, 93
      define :DELETE_ALERTS_REQUEST, 94
      define :METRICS_SUMMARY_REQUEST, 95
      define :METRICS_SUMMARY_RESPONSE, 96
      define :PCAP_SLICES_REQUEST, 97
      define :SERVICE_REQUEST, 101
      define :SERVICE_RESPONSE, 102
      define :CONFIG_REQUEST, 103
      define :CONFIG_RESPONSE, 104
      define :LOG_REQUEST, 105
      define :LOG_RESPONSE, 106
      define :CONTEXT_CREATE_REQUEST, 108
      define :CONTEXT_DELETE_REQUEST, 109
      define :CONTEXT_START_REQUEST, 110
      define :CONTEXT_STOP_REQUEST, 111
      define :CONTEXT_INFO_REQUEST, 112
      define :CONTEXT_INFO_RESPONSE, 113
      define :CONTEXT_CONFIG_REQUEST, 114
      define :CONTEXT_CONFIG_RESPONSE, 115
      define :DOMAIN_REQUEST, 116
      define :DOMAIN_RESPONSE, 117
      define :NODE_CONFIG_REQUEST, 118
      define :NODE_CONFIG_RESPONSE, 119
      define :ASYNC_REQUEST, 120
      define :ASYNC_RESPONSE, 121
      define :FILE_REQUEST, 122
      define :FILE_RESPONSE, 123
      define :SUBSYSTEM_INIT, 124
      define :SUBSYSTEM_EXIT, 125
      define :GRAPH_REQUEST, 130
      define :GRAPH_RESPONSE, 131
      define :AGGREGATE_SESSIONS_REQUEST, 132
      define :AGGREGATE_SESSIONS_RESPONSE, 133
      define :RUNTOOL_REQUEST, 134
      define :RUNTOOL_RESPONSE, 135
      define :HA_CONTROL_REQUEST, 140
      define :HA_CONTROL_RESPONSE, 141
      define :DOMAIN_PING, 142
      define :TOOL_INFO_REQUEST, 143
      define :TOOL_INFO_RESPONSE, 144
    end

  end

  class HelloRequest < ::Protobuf::Message; end
  class HelloResponse < ::Protobuf::Message; end
  class ErrorResponse < ::Protobuf::Message; end
  class OKResponse < ::Protobuf::Message; end
  class CounterItemRequest < ::Protobuf::Message; end
  class CounterItemResponse < ::Protobuf::Message; end
  class CounterGroupTopperRequest < ::Protobuf::Message; end
  class CounterGroupTopperResponse < ::Protobuf::Message; end
  class SearchKeysRequest < ::Protobuf::Message; end
  class SearchKeysResponse < ::Protobuf::Message; end
  class CounterGroupInfoRequest < ::Protobuf::Message; end
  class CounterGroupInfoResponse < ::Protobuf::Message; end
  class QuerySessionsRequest < ::Protobuf::Message; end
  class QuerySessionsResponse < ::Protobuf::Message; end
  class AggregateSessionsRequest < ::Protobuf::Message; end
  class AggregateSessionsResponse < ::Protobuf::Message
    class KeyTCount < ::Protobuf::Message; end
    class TagGroup < ::Protobuf::Message; end

  end

  class UpdateKeyRequest < ::Protobuf::Message; end
  class SessionTrackerRequest < ::Protobuf::Message; end
  class SessionTrackerResponse < ::Protobuf::Message; end
  class QueryAlertsRequest < ::Protobuf::Message; end
  class QueryAlertsResponse < ::Protobuf::Message; end
  class QueryResourcesRequest < ::Protobuf::Message; end
  class QueryResourcesResponse < ::Protobuf::Message; end
  class AggregateResourcesRequest < ::Protobuf::Message; end
  class AggregateResourcesResponse < ::Protobuf::Message
    class KeyTCount < ::Protobuf::Message; end

  end

  class KeySpaceRequest < ::Protobuf::Message
    class KeySpace < ::Protobuf::Message; end

  end

  class KeySpaceResponse < ::Protobuf::Message; end
  class TopperTrendRequest < ::Protobuf::Message; end
  class TopperTrendResponse < ::Protobuf::Message; end
  class SubscribeCtl < ::Protobuf::Message
    class StabberType < ::Protobuf::Enum
      define :ST_COUNTER_ITEM, 0
      define :ST_ALERT, 1
      define :ST_FLOW, 2
      define :ST_TOPPER, 3
    end

    class CtlType < ::Protobuf::Enum
      define :CT_SUBSCRIBE, 0
      define :CT_UNSUBSCRIBE, 1
    end

  end

  class QueryFTSRequest < ::Protobuf::Message; end
  class QueryFTSResponse < ::Protobuf::Message; end
  class TimeSlicesRequest < ::Protobuf::Message; end
  class PcapSlicesRequest < ::Protobuf::Message; end
  class TimeSlicesResponse < ::Protobuf::Message
    class SliceT < ::Protobuf::Message; end

  end

  class DeleteAlertsRequest < ::Protobuf::Message; end
  class MetricsSummaryRequest < ::Protobuf::Message; end
  class MetricsSummaryResponse < ::Protobuf::Message; end
  class LogRequest < ::Protobuf::Message; end
  class LogResponse < ::Protobuf::Message; end
  class DomainRequest < ::Protobuf::Message; end
  class DomainResponse < ::Protobuf::Message
    class Node < ::Protobuf::Message; end

  end

  class HAControlRequest < ::Protobuf::Message
    class HAOperation < ::Protobuf::Enum
      define :HA_TEST_REACHABILITY, 0
      define :HA_SWITCH_BACKUP, 1
      define :HA_SWITCH_PRIMARY, 2
    end

  end

  class HAControlResponse < ::Protobuf::Message; end
  class ToolInfoRequest < ::Protobuf::Message; end
  class ToolInfoResponse < ::Protobuf::Message; end
  class NodeConfigRequest < ::Protobuf::Message
    class IntelFeed < ::Protobuf::Message; end

  end

  class NodeConfigResponse < ::Protobuf::Message
    class Node < ::Protobuf::Message; end

  end

  class ContextCreateRequest < ::Protobuf::Message; end
  class ContextInfoRequest < ::Protobuf::Message; end
  class ContextInfoResponse < ::Protobuf::Message
    class Item < ::Protobuf::Message; end

  end

  class ContextDeleteRequest < ::Protobuf::Message; end
  class ContextStartRequest < ::Protobuf::Message; end
  class ContextStopRequest < ::Protobuf::Message; end
  class ContextConfigRequest < ::Protobuf::Message; end
  class ContextConfigResponse < ::Protobuf::Message
    class Layer < ::Protobuf::Message; end

  end

  class PcapRequest < ::Protobuf::Message; end
  class PcapResponse < ::Protobuf::Message; end
  class GrepRequest < ::Protobuf::Message; end
  class GrepResponse < ::Protobuf::Message; end
  class ProbeStatsRequest < ::Protobuf::Message; end
  class ProbeStatsResponse < ::Protobuf::Message; end
  class AsyncResponse < ::Protobuf::Message; end
  class AsyncRequest < ::Protobuf::Message; end
  class FileRequest < ::Protobuf::Message; end
  class FileResponse < ::Protobuf::Message; end
  class GraphRequest < ::Protobuf::Message; end
  class GraphResponse < ::Protobuf::Message; end
  class RunToolRequest < ::Protobuf::Message
    class NodeTool < ::Protobuf::Enum
      define :PING, 1
      define :DF, 2
      define :GEOQUERY, 3
      define :TOP, 4
      define :BGPQUERY, 5
    end

  end

  class RunToolResponse < ::Protobuf::Message; end


  ##
  # File Options
  #
  set_option :optimize_for, ::Google::Protobuf::FileOptions::OptimizeMode::LITE_RUNTIME


  ##
  # Message Fields
  #
  class Timestamp
    required :int64, :tv_sec, 1
    optional :int64, :tv_usec, 2, :default => 0
  end

  class TimeInterval
    required ::TRP::Timestamp, :from, 1
    required ::TRP::Timestamp, :to, 2
  end

  class StatsTuple
    required ::TRP::Timestamp, :ts, 1
    required :int64, :val, 2
  end

  class StatsArray
    required :int64, :ts_tv_sec, 1
    repeated :int64, :values, 2
  end

  class MeterValues
    required :int32, :meter, 1
    repeated ::TRP::StatsTuple, :values, 2
    optional :int64, :total, 3
    optional :int64, :seconds, 4
  end

  class MeterInfo
    required :int32, :id, 1
    required ::TRP::MeterInfo::MeterType, :type, 2
    required :int32, :topcount, 3
    required :string, :name, 4
    optional :string, :description, 5
    optional :string, :units, 6
  end

  class KeyStats
    required :string, :counter_group, 2
    required ::TRP::KeyT, :key, 3
    repeated ::TRP::MeterValues, :meters, 4
  end

  class KeyT
    class NameValueT
      required :string, :attr_name, 1
      required :string, :attr_value, 2
    end

    optional :string, :key, 1
    optional :string, :readable, 2
    optional :string, :label, 3
    optional :string, :description, 4
    optional :int64, :metric, 5
    repeated ::TRP::KeyT::NameValueT, :attributes, 6
    optional :int64, :metric_max, 7
    optional :int64, :metric_min, 8
    optional :int64, :metric_avg, 9
  end

  class CounterGroupT
    class Crosskey
      required :string, :parentguid, 1
      required :string, :crosskeyguid_1, 2
      optional :string, :crosskeyguid_2, 3
    end

    required :string, :guid, 1
    required :string, :name, 2
    optional :int64, :bucket_size, 3
    optional ::TRP::TimeInterval, :time_interval, 4
    optional :int64, :topper_bucket_size, 5
    repeated ::TRP::MeterInfo, :meters, 6
    optional ::TRP::CounterGroupT::Crosskey, :crosskey, 7
  end

  class SessionT
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

  class AlertT
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
    optional :string, :dispatch_message1, 12
    optional :string, :dispatch_message2, 13
    optional :int64, :occurrances, 14, :default => 1
    optional :string, :group_by_key, 15
    optional :string, :probe_id, 16
    optional :string, :alert_status, 17
    optional :int64, :acknowledge_flag, 18
  end

  class ResourceT
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

  class DocumentT
    class Flow
      required ::TRP::Timestamp, :time, 1
      required :string, :key, 2
    end

    required :string, :dockey, 1
    optional :string, :fts_attributes, 2
    optional :string, :fullcontent, 3
    repeated ::TRP::DocumentT::Flow, :flows, 4
    optional :string, :probe_id, 5
  end

  class VertexGroupT
    required :string, :vertex_group, 1
    repeated ::TRP::KeyT, :vertex_keys, 2
  end

  class EdgeGraphT
    required ::TRP::TimeInterval, :time_interval, 4
    repeated ::TRP::VertexGroupT, :vertex_groups, 3
  end

  class NameValue
    required :string, :name, 1
    optional :string, :value, 2
  end

  class Message
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
    optional ::TRP::GraphRequest, :graph_request, 130
    optional ::TRP::GraphResponse, :graph_response, 131
    optional ::TRP::AggregateSessionsRequest, :aggregate_sessions_request, 140
    optional ::TRP::AggregateSessionsResponse, :aggregate_sessions_response, 141
    optional ::TRP::AggregateResourcesRequest, :aggregate_resources_request, 142
    optional ::TRP::AggregateResourcesResponse, :aggregate_resources_response, 143
    optional ::TRP::RunToolRequest, :run_tool_request, 144
    optional ::TRP::RunToolResponse, :run_tool_response, 145
    optional ::TRP::HAControlRequest, :ha_control_request, 150
    optional ::TRP::HAControlResponse, :ha_control_response, 151
    optional ::TRP::ToolInfoRequest, :tool_info_request, 152
    optional ::TRP::ToolInfoResponse, :tool_info_response, 153
    optional :string, :destination_node, 200
    optional :string, :probe_id, 201
    optional :bool, :run_async, 202
  end

  class HelloRequest
    required :string, :station_id, 1
    optional :string, :message, 2
  end

  class HelloResponse
    required :string, :station_id, 1
    optional :string, :station_id_request, 2
    optional :string, :message, 3
    optional :int64, :local_timestamp, 4
    optional :string, :local_timestamp_string, 5
    optional :bool, :is_primary, 6
  end

  class ErrorResponse
    required :int64, :original_command, 1
    required :int64, :error_code, 2
    required :string, :error_message, 3
  end

  class OKResponse
    required :int64, :original_command, 1
    optional :string, :message, 2
  end

  class CounterItemRequest
    required :string, :counter_group, 2
    optional :int64, :meter, 3
    required ::TRP::KeyT, :key, 4
    required ::TRP::TimeInterval, :time_interval, 5
    optional :int64, :volumes_only, 6, :default => 0
  end

  class CounterItemResponse
    required :string, :counter_group, 1
    required ::TRP::KeyT, :key, 2
    optional ::TRP::StatsArray, :totals, 3
    repeated ::TRP::StatsArray, :stats, 4
  end

  class CounterGroupTopperRequest
    required :string, :counter_group, 2
    optional :int64, :meter, 3, :default => 0
    optional :int64, :maxitems, 4, :default => 100
    optional ::TRP::TimeInterval, :time_interval, 5
    optional ::TRP::Timestamp, :time_instant, 6
    optional :int64, :flags, 7
    optional :bool, :resolve_keys, 8, :default => true
    optional :string, :key_filter, 9
    optional :string, :inverse_key_filter, 10
  end

  class CounterGroupTopperResponse
    required :string, :counter_group, 2
    required :int64, :meter, 3
    optional :int64, :sysgrouptotal, 4
    repeated ::TRP::KeyT, :keys, 6
  end

  class SearchKeysRequest
    required :string, :counter_group, 2
    optional :int64, :maxitems, 3, :default => 100
    optional :string, :pattern, 4
    optional :string, :label, 5
    repeated :string, :keys, 6
    optional :int64, :offset, 7, :default => 0
    optional :bool, :get_totals, 8, :default => false
    optional :bool, :get_attributes, 9, :default => false
  end

  class SearchKeysResponse
    required :string, :counter_group, 2
    repeated ::TRP::KeyT, :keys, 3
    optional :int64, :total_count, 4
  end

  class CounterGroupInfoRequest
    optional :string, :counter_group, 2
    optional :bool, :get_meter_info, 3, :default => false
  end

  class CounterGroupInfoResponse
    repeated ::TRP::CounterGroupT, :group_details, 2
  end

  class QuerySessionsRequest
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

  class QuerySessionsResponse
    required :string, :session_group, 2
    repeated ::TRP::SessionT, :sessions, 3
    optional :string, :outputpath, 4
  end

  class AggregateSessionsRequest
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    optional ::TRP::TimeInterval, :time_interval, 3
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
    optional :int64, :aggregate_topcount, 19, :default => 100
    repeated :string, :group_by_fields, 20
  end

  class AggregateSessionsResponse
    class KeyTCount
      required ::TRP::KeyT, :key, 1
      required :int64, :count, 2
      required :int64, :metric, 3
    end

    class TagGroup
      required :string, :group_name, 1
      repeated ::TRP::AggregateSessionsResponse::KeyTCount, :tag_metrics, 2
    end

    required :string, :session_group, 2
    optional ::TRP::TimeInterval, :time_interval, 3
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :source_ip, 5
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :source_port, 6
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :dest_ip, 7
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :dest_port, 8
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :any_ip, 9
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :any_port, 10
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :ip_pair, 11
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :protocol, 12
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :flowtag, 13
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :nf_routerid, 14
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :nf_ifindex_in, 15
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :nf_ifindex_out, 16
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :subnet_24, 17
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :internal_port, 18
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :internal_ip, 19
    repeated ::TRP::AggregateSessionsResponse::KeyTCount, :external_ip, 20
    repeated ::TRP::AggregateSessionsResponse::TagGroup, :tag_group, 21
  end

  class UpdateKeyRequest
    required :string, :counter_group, 2
    repeated ::TRP::KeyT, :keys, 4
    optional :bool, :remove_all_attributes, 5
    repeated :string, :remove_attributes, 6
  end

  class SessionTrackerRequest
    optional :string, :session_group, 2, :default => "{99A78737-4B41-4387-8F31-8077DB917336}"
    optional :int64, :tracker_id, 3
    optional :int64, :maxitems, 4, :default => 100
    required ::TRP::TimeInterval, :time_interval, 5
    optional :bool, :resolve_keys, 6, :default => true
    optional :string, :tracker_name, 7
  end

  class SessionTrackerResponse
    required :string, :session_group, 2
    repeated ::TRP::SessionT, :sessions, 3
    optional :int64, :tracker_id, 4
  end

  class QueryAlertsRequest
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
    optional :bool, :approx_count_only, 22, :default => false
  end

  class QueryAlertsResponse
    required :string, :alert_group, 2
    repeated ::TRP::AlertT, :alerts, 3
    optional :int64, :approx_count, 4
  end

  class QueryResourcesRequest
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
    optional :bool, :approx_count_only, 18, :default => false
    repeated :string, :exclude_iplist, 19
    optional :bool, :invert_regex, 20, :default => false
  end

  class QueryResourcesResponse
    required :string, :resource_group, 2
    repeated ::TRP::ResourceT, :resources, 3
    optional :int64, :approx_count, 4
  end

  class AggregateResourcesRequest
    required ::TRP::QueryResourcesRequest, :query, 1
    optional :int64, :aggregate_topcount, 2, :default => 100
  end

  class AggregateResourcesResponse
    class KeyTCount
      required ::TRP::KeyT, :key, 1
      required :int64, :count, 2
    end

    repeated ::TRP::AggregateResourcesResponse::KeyTCount, :source_ip, 5
    repeated ::TRP::AggregateResourcesResponse::KeyTCount, :source_port, 6
    repeated ::TRP::AggregateResourcesResponse::KeyTCount, :destination_ip, 7
    repeated ::TRP::AggregateResourcesResponse::KeyTCount, :destination_port, 8
    repeated ::TRP::AggregateResourcesResponse::KeyTCount, :uri, 9
    repeated ::TRP::AggregateResourcesResponse::KeyTCount, :userlabel, 10
  end

  class KeySpaceRequest
    class KeySpace
      required ::TRP::KeyT, :from_key, 1
      required ::TRP::KeyT, :to_key, 2
    end

    required :string, :counter_group, 2
    required ::TRP::TimeInterval, :time_interval, 3
    optional :int64, :maxitems, 4, :default => 100
    repeated ::TRP::KeySpaceRequest::KeySpace, :spaces, 5
    optional :bool, :resolve_keys, 6, :default => true
    optional :bool, :totals_only, 7, :default => false
  end

  class KeySpaceResponse
    optional :string, :counter_group, 2
    repeated ::TRP::KeyT, :hits, 3
    optional :int64, :total_hits, 4
  end

  class TopperTrendRequest
    required :string, :counter_group, 2
    optional :int64, :meter, 3, :default => 0
    optional :int64, :maxitems, 4, :default => 100
    optional ::TRP::TimeInterval, :time_interval, 5
  end

  class TopperTrendResponse
    required :string, :counter_group, 2
    required :int64, :meter, 3
    repeated ::TRP::KeyStats, :keytrends, 4
  end

  class SubscribeCtl
    required :string, :context_name, 1
    required ::TRP::SubscribeCtl::CtlType, :ctl, 2
    required ::TRP::SubscribeCtl::StabberType, :type, 3
    optional :string, :guid, 4
    optional :string, :key, 5
    optional :int64, :meterid, 6
  end

  class QueryFTSRequest
    required ::TRP::TimeInterval, :time_interval, 2
    required :string, :fts_group, 3
    required :string, :keywords, 4
    optional :int64, :maxitems, 5, :default => 100
    optional :bool, :approx_count_only, 6, :default => false
  end

  class QueryFTSResponse
    required :string, :fts_group, 2
    repeated ::TRP::DocumentT, :documents, 3
    optional :int64, :approx_count, 4
  end

  class TimeSlicesRequest
    optional :bool, :get_disk_usage, 1, :default => false
    optional :bool, :get_all_engines, 2, :default => false
    optional :bool, :get_total_window, 3, :default => false
  end

  class PcapSlicesRequest
    required :string, :context_name, 1
    optional :bool, :get_total_window, 2, :default => false
  end

  class TimeSlicesResponse
    class SliceT
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

  class DeleteAlertsRequest
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

  class MetricsSummaryRequest
    optional ::TRP::TimeInterval, :time_interval, 1
    required :string, :metric_name, 2
    optional :bool, :totals_only, 3, :default => true
  end

  class MetricsSummaryResponse
    required :string, :metric_name, 2
    repeated ::TRP::StatsTuple, :vals, 3
  end

  class LogRequest
    required :string, :context_name, 1
    required :string, :log_type, 2
    optional :string, :regex_filter, 4
    optional :int64, :maxlines, 5, :default => 1000
    optional :string, :continue_logfilename, 6
    optional :int64, :continue_seekpos, 7
    optional :bool, :latest_run_only, 8, :default => false
  end

  class LogResponse
    required :string, :context_name, 1
    optional :string, :logfilename, 6
    optional :int64, :seekpos, 7
    repeated :string, :log_lines, 8
  end

  class DomainRequest
    required ::TRP::DomainOperation, :cmd, 1
    optional :string, :station_id, 2
    optional :string, :params, 3
    optional ::TRP::DomainNodeType, :nodetype, 4
  end

  class DomainResponse
    class Node
      required :string, :id, 1
      required ::TRP::DomainNodeType, :nodetype, 2
      optional :string, :station_id, 3
      optional :string, :extra_info, 4
      optional ::TRP::Timestamp, :register_time, 5
      optional ::TRP::Timestamp, :heartbeat_time, 6
      optional :bool, :is_primary, 7, :default => true
    end

    required ::TRP::DomainOperation, :cmd, 1
    repeated ::TRP::DomainResponse::Node, :nodes, 2
    optional :string, :req_params, 3
    optional :string, :params, 4
    optional :bool, :need_reconnect, 5, :default => false
  end

  class HAControlRequest
    required ::TRP::HAControlRequest::HAOperation, :cmd, 1
    optional :string, :station_id, 2
    optional :string, :params, 3
  end

  class HAControlResponse
    optional :bool, :control_success, 1
    optional :string, :station_id, 2
    optional :string, :status_message, 3
    optional :bool, :primary_reachable, 4
    optional :bool, :backup_reachable, 5
  end

  class ToolInfoRequest
    optional :string, :context_name, 1
    optional :string, :tool_name, 2
    repeated :string, :tool_info_requested, 3
  end

  class ToolInfoResponse
    repeated ::TRP::NameValue, :tool_info, 1
  end

  class NodeConfigRequest
    class IntelFeed
      required :string, :guid, 1
      optional :string, :name, 2
      optional :string, :download_rules, 3
      repeated :string, :uri, 4
      repeated :string, :usernodes, 5
      optional :int64, :sub_feed_id, 6, :default => -1
    end

    optional :string, :message, 1
    optional ::TRP::NodeConfigRequest::IntelFeed, :add_feed, 2
    optional ::TRP::NodeConfigRequest::IntelFeed, :process_new_feed, 3
    optional :bool, :get_all_nodes, 4, :default => true
    repeated ::TRP::NameValue, :query_config, 5
    optional ::TRP::NodeConfigRequest::IntelFeed, :remove_feed, 6
  end

  class NodeConfigResponse
    class Node
      required :string, :id, 1
      required ::TRP::DomainNodeType, :nodetype, 2
      required :string, :description, 3
      required :string, :public_key, 4
    end

    repeated ::TRP::NodeConfigResponse::Node, :domains, 1
    repeated ::TRP::NodeConfigResponse::Node, :hubs, 2
    repeated ::TRP::NodeConfigResponse::Node, :probes, 3
    repeated :string, :feeds, 4
    repeated ::TRP::NameValue, :config_values, 5
  end

  class ContextCreateRequest
    required :string, :context_name, 1
    optional :string, :clone_from, 2
  end

  class ContextInfoRequest
    optional :string, :context_name, 1
    optional :bool, :get_size_on_disk, 2, :default => false
    optional :string, :tool_name, 3
  end

  class ContextInfoResponse
    class Item
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
      optional :string, :node_version, 11
    end

    repeated ::TRP::ContextInfoResponse::Item, :items, 1
  end

  class ContextDeleteRequest
    required :string, :context_name, 1
    optional :bool, :reset_data, 2
  end

  class ContextStartRequest
    required :string, :context_name, 1
    optional :string, :mode, 2
    optional :bool, :background, 3, :default => true
    optional :string, :pcap_path, 4
    optional :string, :run_tool, 5
    optional :string, :tool_ids_config, 6
    optional :string, :tool_av_config, 7
    optional :string, :cmd_in, 8
    optional :string, :cmd_out, 9
    optional :string, :cmd_args, 10
  end

  class ContextStopRequest
    required :string, :context_name, 1
    optional :string, :run_tool, 5
  end

  class ContextConfigRequest
    required :string, :context_name, 1
    optional :string, :profile, 2
    optional :string, :params, 3
    optional :bytes, :push_config_blob, 4
    repeated ::TRP::NameValue, :query_config, 5
    repeated ::TRP::NameValue, :set_config_values, 6
  end

  class ContextConfigResponse
    class Layer
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
    repeated ::TRP::NameValue, :config_values, 10
    repeated ::TRP::ContextConfigResponse::Layer, :layers, 11
  end

  class PcapRequest
    required :string, :context_name, 1
    optional :int64, :max_bytes, 2, :default => 100000000
    optional ::TRP::CompressionType, :compress_type, 3, :default => ::TRP::CompressionType::UNCOMPRESSED
    optional ::TRP::TimeInterval, :time_interval, 4
    optional :string, :save_file_prefix, 5
    optional :string, :filter_expression, 6
    repeated :string, :merge_pcap_files, 7
    optional :bool, :delete_after_merge, 8, :default => true
    optional ::TRP::PcapFormat, :format, 9, :default => ::TRP::PcapFormat::LIBPCAP
  end

  class PcapResponse
    required :string, :context_name, 1
    optional ::TRP::PcapFormat, :format, 2, :default => ::TRP::PcapFormat::LIBPCAP
    optional ::TRP::CompressionType, :compress_type, 3, :default => ::TRP::CompressionType::UNCOMPRESSED
    optional ::TRP::TimeInterval, :time_interval, 4
    optional :int64, :num_bytes, 5
    optional :string, :sha1, 6
    optional :bytes, :contents, 7
    optional :string, :save_file, 8
  end

  class GrepRequest
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

  class GrepResponse
    required :string, :context_name, 1
    repeated ::TRP::SessionT, :sessions, 2
    repeated :string, :hints, 3
    optional :string, :probe_id, 4
  end

  class ProbeStatsRequest
    required :string, :context_name, 1
    optional :string, :param, 2
  end

  class ProbeStatsResponse
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

  class AsyncResponse
    required :int64, :token, 1
    optional :string, :response_message, 3
    optional ::TRP::Message, :response, 4
  end

  class AsyncRequest
    required :int64, :token, 1
    optional :string, :request_message, 2
  end

  class FileRequest
    required :string, :uri, 1
    required :int64, :position, 2
    optional :string, :params, 3
    optional :string, :context_name, 4
    optional :bool, :delete_on_eof, 5, :default => false
  end

  class FileResponse
    required :string, :uri, 1
    required :bool, :eof, 2
    optional :int64, :position, 3
    optional :bytes, :content, 4
    optional :string, :request_params, 5
    optional :string, :context_name, 6
  end

  class GraphRequest
    required ::TRP::TimeInterval, :time_interval, 1
    required :string, :subject_group, 2
    required ::TRP::KeyT, :subject_key, 3
    optional :string, :vertex_group, 4
  end

  class GraphResponse
    required :string, :subject_group, 1
    required ::TRP::KeyT, :subject_key, 2
    repeated ::TRP::EdgeGraphT, :graphs, 3
  end

  class RunToolRequest
    required :string, :context_name, 1
    required ::TRP::RunToolRequest::NodeTool, :tool, 2
    optional :string, :tool_input, 3
  end

  class RunToolResponse
    required :string, :context_name, 1
    optional :string, :tool_output, 2
  end

end

