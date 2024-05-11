module Response
    # class ForbiddenError < StandardError
    #     def initialize(message)
    #       super(message)
    #     end
    # end

    def build_success(messages, data)
        render json: {
            messages: messages,
            success: true,
            status: 200,
            data: data
        },
        status: :ok
    end

    def build_success_create(messages)
        render json: {
            messages: messages,
            success: true,
            status: 201,
            data: []
        },
        status: :created
    end

    def build_success_inactive(messages, data)
        render json: {
            messages: messages,
            success: true,
            status: 203,
            data: data            
        },
        status: 203
    end

    def build_success_content(messages)
        render json: {
            messages: messages,
            success: true,
            status: 204,
            data: []
        },
        status: :no_content
    end
      
    def build_error(messages)
        render json: {
            messages: messages,
            success: false,
            status: 422, 
            data: []                     
        },
        status: :unprocessable_entity
    end

    def build_error_permisso(messages)
        render json: {
            messages: messages,
            success: false,
            status: 404,
            data: []            
        },
        status: :forbidden
    end
    
    def build_error_invalido(messages)
        render json: {
            messages: messages,
            success: false,
            status: 401,
            data: []            
        },
        status: :unauthorized
    end
end