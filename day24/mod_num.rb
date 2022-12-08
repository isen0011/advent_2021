require_relative "alu"
class ModNum
  attr_accessor :alu
  def initialize
    self.alu = ALU.new("input.txt")
  end

  def find_number
    9.downto(1) do |n1|
      9.downto(1) do |n2|
        puts "trillion"
        9.downto(1) do |n3|
          9.downto(1) do |n4|
            9.downto(1) do |n5|
              puts "billion"
              9.downto(1) do |n6|
                9.downto(1) do |n7|
                  9.downto(1) do |n8|
                    puts "million"
                    9.downto(1) do |n9|
                      9.downto(1) do |n10|
                        9.downto(1) do |n11|
                          puts "thousand"
                          9.downto(1) do |n12|
                            9.downto(1) do |n13|
                              9.downto(1) do |n14|
                                mn = "#{n1}#{n2}#{n3}#{n4}#{n5}#{n6}#{n7}#{n8}#{n9}#{n10}#{n11}#{n12}#{n13}#{n14}"
                                alu.run(mn)
                                return mn if alu.context.z == 0
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
