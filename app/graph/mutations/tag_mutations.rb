module TagMutations
  Create = GraphQL::Relay::Mutation.define do
    name 'CreateTag'
    input_field :tag, TagInputType
    input_field :auth_token, !types.String

    return_field :tags, types[TagType]

    resolve -> (inputs, ctx) do
      user = User.find_by(auth_token: inputs[:auth_token])
      Tag.create(
        tag: inputs[:tag].tag,
        user: user
      )
      tags = Tag.all
      tags
    end
  end
end