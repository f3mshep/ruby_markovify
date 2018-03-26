load 'splitter.rb'
load 'dict.rb'
require 'pry'

splitter = SplitSentence.new("A friendly desert community where the sun is hot, the moon is beautiful, and mysterious lights pass overhead while we all pretend to sleep. Welcome to Night Vale.
Hello listeners. To start things off I've been asked to read this brief notice: the city council announces the opening of a new dog park at the corner of Earl and Summerset near the Ralph's. They would like to remind everyone that dogs are not allowed in the dog park. People are not allowed in the dog park. It is possible you will see hooded figures in the dog park. Do not approach them. Do not approach the dog park. The fence is electrified and highly dangerous. Try not to look at the dog park, and especially do not look for any period of time at the hooded figures. The dog park will not harm you.
And now the news.")

splitter.split_text

dict = Dictionary.new(splitter)

dict.construct_chain

binding.pry