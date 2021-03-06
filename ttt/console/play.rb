require_relative 'input'
require_relative 'collect'
require_relative 'console_display'
require '../core/Symbols'
require '../core/Board'
require '../core/Game'

module Console

  class Play
    attr_accessor :input_source, :collect, :board, :display_source

    def initialize(input_source, collect, display_source)
      @input_source = input_source
      @collect = collect
      @display_source = display_source
    end

    def set_up
      @collect.welcome
      all_symbols = @collect.prompt_symbols
      ai_symbol = all_symbols.first
      human_symbol = all_symbols.last
      current_symbol = @collect.set_first_player
      symbols = Symbols.new(ai_symbol, human_symbol)
      @board = Board.new(3)
      game = Game.new(@board, symbols, current_symbol,
                      @input_source, @display_source)
      winner = game.start
      puts winner
    end

  end
end