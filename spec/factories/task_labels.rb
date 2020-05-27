FactoryBot.define do
  factory :task_label, class: TaskLabel do
    label_id { 1 }
    task_id { 1 }
  end
end