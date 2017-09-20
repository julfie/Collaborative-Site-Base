json.array!(@project_roles) do |project_role|
  json.extract! project_role, :id
  json.url project_role_url(project_role, format: :json)
end
