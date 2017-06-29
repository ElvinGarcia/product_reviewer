
#gem controller
 class ProductReviews::ProductController


    def call

      greetings



      create_main_objects

        @objects_created = ProductReviews::Catagories.all

        main_catagories_list (@objects_created)
      system("clear")



    ProductReviews::Board.display(@selected_obj, @selected_obj_description)

      if ProductReviews::Board.choice(@selected_obj) == true
       call
      end

  end

    def greetings
      puts "****** Welcome to The Product Reviewer ****"
      puts "*******************************************"
      puts "Choose a Catagory to Get Started"
      puts " "

    end

    def create_main_objects
      if  ProductReviews::Catagories.all.empty? == true
        main_productlist = ProductReviews::Scraper.catagory
        ProductReviews::Catagories.create_from_hashes(main_productlist)
      end
    end

    def main_catagories_list (objects_created)
      objects_created.each.with_index(1) do |obj, i |

          puts "#{i} #{obj.name}"
        end

      puts " "
      @input = gets.downcase.strip!
      puts ""
      if @input.to_i <= 0 || @input.to_i > objects_created.size
        puts "#{@input} Is an Invalid Option"
        puts "Try Again !!"
        puts ""

        main_catagories_list (@objects_created)
      else
        add_subcatagories(@objects_created)
      end
    end

    def add_subcatagories(array_of_obj)

          obj = array_of_obj[@input.to_i-1]
        if obj.subcatagories.empty? == true
          array = ProductReviews::Scraper.profile_page(obj.url)

          array.each do |element|
            if element[:description] != nil
              obj.description = element[:description]
              else
              obj.subcatagories << element
            end
          end
        end
        subcatagories_list(@objects_created)
      end

    def subcatagories_list(array_of_obj)

      obj = array_of_obj[@input.to_i-1]

      obj.subcatagories.each.with_index(1) do |obj, i|
          if obj[:title] != nil
            puts "#{i} #{obj[:title]}"
          end
        end
        puts " "
        @input = gets.downcase.strip
        puts ""
      if @input.to_i <= 0 || @input.to_i > obj.subcatagories.size
        puts "#{@input} Is an Invalid Option"
        puts "Try Again !!"
        puts ""
        main_catagories_list (@objects_created)
       else

       @selected_obj = obj.subcatagories[@input.to_i-1]
       @selected_obj_description = obj.description
     end
     ProductReviews::Board.display(@selected_obj, @selected_obj_description)
    end




 end
