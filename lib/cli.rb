class Cli

  def run
    welcome
    display_states
    menu
  end

  def welcome
    puts "PROJECT BIGFOOT"
    puts "Bigfoot Sighting Reports for the United States"
    puts "Can Bigfoot swim?"
    puts "Maybe..."
    puts "But there haven't been any sighting reports in Hawaii...yet."
    puts "Select a state from the list below:"
  end

  def display_states
    Scraper.scrape_bfro
    State.states_only.each.with_index(1) do |state, index|
      puts "#{index}. #{state.name}"
    end
  end

  def menu
      puts "Choose a state by entering the corresponding number or type 'done' to leave the program."
    input = gets.chomp

    state_input = State.all[input.to_i - 1]

      until input == "done"
        if input.to_i > 0 && input.to_i < 49
          Scraper.scrape_reports(state_input)
          puts "These are the 3 most recent reports that have been made for this state."
          puts "***Please note that the actual sigthing report date may be older than when the event was reported***"
          puts state_input.reports
          puts "Class A reports are first-hand sightings from witnesses where misinterpretations and misidentifications can be ruled out."
          puts "Class B reports may be first or second-hand accounts, but there is greater possibility that misinterpretation and/or misidetification could have occured."
          choice
        elsif input.downcase == "done"
          goodbye
        else
          puts "Incorrect input."
          puts "Try again or type exit to leave the program"
          menu
        end
      end
    end

  def choice
    puts "Would you like to see reports from another state? y/n"
  input = gets.strip.downcase
    case input
      when "y"
        display_states
        menu
      when "n"
        goodbye
      else
        puts "Incorrect input."
        puts "Try again."
        choice
      end
    end

    def goodbye
        puts "This data can be found on the Bigfoot Field Researchers Organizations's
        website at www.bfro.net along with other great information about BigFoot."
        puts "Hope you enjoyed PROJECT BIGFOOT!"
        exit
    end
end
