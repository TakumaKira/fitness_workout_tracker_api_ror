# README

## Testing

### Setup Test Environment

1. Install required gems:
```bash
bundle install
```

2. Generate RSpec configuration:
```bash
rails generate rspec:install
```

3. Set up test database:
```bash
rails db:test:prepare
```

### Running Tests

Run all tests:
```bash
bundle exec rspec
```

Run specific test files:
```bash
# Test access control for workouts
bundle exec rspec spec/requests/api/workouts_controller_spec.rb

# Test access control for exercises
bundle exec rspec spec/requests/api/exercises_controller_spec.rb

# Test access control for comments
bundle exec rspec spec/requests/api/comments_controller_spec.rb
```

Run specific test by line number:
```bash
bundle exec rspec spec/requests/api/workouts_controller_spec.rb:18
```

### Test Coverage

The tests verify that users cannot access or modify other users' resources:

#### Workouts
- Cannot view other user's workout
- Cannot update other user's workout
- Cannot delete other user's workout

#### Exercises
- Cannot view other user's exercise
- Cannot update other user's exercise
- Cannot delete other user's exercise

#### Comments
- Cannot view comments on other user's workout
- Cannot add comment to other user's workout
- Cannot update other user's comment
- Cannot delete other user's comment

### HTTP Status Codes
- 404 Not Found: Accessing non-existent or unauthorized resources
- 403 Forbidden: Unauthorized operations on accessible resources
