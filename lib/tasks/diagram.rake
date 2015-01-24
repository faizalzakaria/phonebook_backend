namespace :diagram do
  namespace :models do

    desc 'Generates an class diagram for all models.'
    task :complete => [:environment] do
      puts "\t\033[1;32mGenerating a complete models diagram ...\033[0m"
      sh "railroady -o models.dot -M"
      sh "dot -Tpng models.dot > models.png"
      puts "\t\033[1;32mCreated models.png\033[0m"
      puts "\t\033[1;32mopen models.png\033[0m"
    end

  end
end
