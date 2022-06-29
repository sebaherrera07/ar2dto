# frozen_string_literal: true

module AR2DTO
  class ModelConfig
    attr_reader :model, :configs

    def initialize(model)
      @model = model
    end

    def setup_config(configs)
      @configs = AR2DTO::Config.instance.as_json.merge(configs.as_json)
    end

    def except
      @except ||= configs["except"]
    end

    def class_name
      @class_name ||= namespaced_class_name.split("::").last
    end

    def namespace
      @namespace ||= namespaced_class_name.deconstantize.presence&.constantize || Object
    end

    def namespaced_class_name
      @namespaced_class_name ||= configs["class_name"] || model_name_replaced_suffix
    end

    private

    def model_name_replaced_suffix
      model.name.sub(/#{configs["replace_suffix"]["from"]}$/, configs["replace_suffix"]["to"].to_s)
    end
  end
end
