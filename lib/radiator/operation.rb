module Radiator
  class Operation
    include OperationIds
    include OperationTypes
    include Utils
    
    def initialize(options = {})
      options.each do |k, v|
        instance_variable_set("@#{k}", type(@type, k, v))
      end
      
      unless Operation::known_operation_names.include? @type
        raise OperationError, "Unsupported operation type: #{@type}"
      end
    end
    
    def to_bytes
      bytes = [id(@type.to_sym)].pack('C')
      
      Operation::param_names(@type.to_sym).each do |p|
        next unless defined? p
        
        v = instance_variable_get("@#{p}")
        bytes += v.to_bytes and next if v.respond_to? :to_bytes
        
        bytes += case v
        when Symbol then pakStr(v.to_s)
        when String then pakStr(v)
        when Integer then paks(v)
        when TrueClass then pakC(1)
        when FalseClass then pakC(0)
        when Array then pakArr(v)
        when Hash then pakHash(v)
        when NilClass then next
        else
          raise OperationError, "Unsupported type: #{v.class}"
        end
      end
      
      bytes
    end
    
    def payload
      params = {}
      
      Operation::param_names(@type.to_sym).each do |p|
        next unless defined? p
        
        v = instance_variable_get("@#{p}")
        next if v.nil?
        next if v.class == Radiator::Type::Future
        
        params[p] = case v
        when Radiator::Type::Beneficiaries then [[0, v.to_h]]
        else; v
        end
      end
      
      [@type, params]
    end
  private
    def self.broadcast_operations_json_path
      @broadcast_operations_json_path ||= "#{File.dirname(__FILE__)}/broadcast_operations.json"
    end
    
    def self.broadcast_operations
      @broadcast_operations ||= JSON[File.read broadcast_operations_json_path]
    end

    def self.known_operation_names
      broadcast_operations.map { |op| op["operation"].to_sym }
    end
    
    def self.param_names(type)
      broadcast_operations.each do |op|
        if op['operation'].to_sym == type.to_sym
          return op['params'].map(&:to_sym)
        end
      end
    end
  end
end
