# frozen_string_literal: true

module Mutations
  class RegisterUser < Mutations::BaseMutation
    argument :params, Types::Input::UserInputType, required: true

    field :note, Types::UserType, null: false

    def resolve(params:)
      user_params = Hash params

      begin
        user = User.create!(user_params)

        { user: }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}: " \
                                    "#{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
