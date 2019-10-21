Rails.application.config.after_initialize do
  # admin_user
  admin = User.find_by(email: 'admin@admin.com')
  if(admin == nil)
    admin = User.new(email: 'admin@admin.com')
    admin.password = 'admin'
    admin.save(validate: false)
  end

  # roles
  roles = [{name: 'admin'}, {name: 'guest'}]
  roles.each { |r| Role.find_or_create_by(r) }

  # admin_user_roles
  role = Role.find_by(name: 'admin')
  UserRole.find_or_create_by(user_id: admin.id, role_id: role.id)

  # permissions
  permissions = [{name: 'create_article',  action: 'create',  resource: 'article'},
                 {name: 'destroy_article', action: 'destroy', resource: 'article'},
                 {name: 'update_article',  action: 'update',  resource: 'article'}]
  permissions.each { |p| Permission.find_or_create_by(p) }

  # role_permissions
  role_permissions = [{role: 'admin', permissions: ['create_article', 'destroy_article', 'update_article']}]
  role_permissions.each do |role_per|
    role = Role.find_by_name(role_per[:role])
    role_per[:permissions].each do |per|
      permission = Permission.find_by_name(per)
      RolePermission.find_or_create_by(role_id: role.id, permission_id: permission.id)
    end
  end
end
