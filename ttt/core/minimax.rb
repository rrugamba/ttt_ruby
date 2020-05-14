require_relative 'ai'
require_relative 'symbols'

class Minimax
  attr_reader :board, :current_symbol, :symbols,
              :ai_symbol, :human_symbol, :winner

  def initialize(board, symbols)
    @board = board
    @symbols = symbols
    @ai_symbol = symbols.ai
    @human_symbol = symbols.human
  end

  def get_best_move
    depth = 1
    best_move = 0
    best_score = -100

    original_board = @board.current_state
    copy_of_board = original_board.clone

    @current_symbol = @ai_symbol

    @board.find_all_empty_positions.each do | position |
      copy_of_board[position] = @current_symbol
      score = compute(copy_of_board, depth += 1 )
      if score > best_score
        best_score = score
        best_move = position
      end
      copy_of_board = original_board.clone
      @current_symbol = @ai_symbol
    end

    @board.update_board_state(original_board)
    best_move
  end

  def compute(board, depth)
    @board.update_board_state(board)
    if @board.has_winner? || @board.tie?
      @winner = @current_symbol
      return evaluate(depth)
    end

    least_score = 100
    original_board = @board.current_state
    copy_of_board = original_board.clone

    @current_symbol = @symbols.switch(@current_symbol)

    @board.find_all_empty_positions.each do | position |
      copy_of_board[position] = @current_symbol
      score = -compute(copy_of_board, depth)
      if score < least_score
        least_score = score
      end
      copy_of_board = original_board.clone
    end

    @board.update_board_state(original_board)
    least_score
  end

  def evaluate(depth)
    if @board.has_winner? &&  @winner == @ai_symbol
      return 10 - depth
    elsif @board.has_winner? && @winner == @human_symbol
      return depth - 10
    else
      return 0
    end
  end

end