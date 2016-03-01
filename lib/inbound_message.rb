class InboundMessage
  STOP_WORDS = %w(stop unsubscribe unsub cancel)

  attr_accessor :from, :to, :body, :cancellation

  def initialize(from, to, body, cancellation)
    @from = from
    @to = to
    @body = body
    @cancellation = cancellation
  end

  def fill_cancellation
    if stop?
      # would actually be real code to add to blacklist
      "Added #{from} to blacklist"
    elsif cancellation
      cancellation.fill
    end
  end

  def response
    if stop?
      "You are unsubscribed from QueueDr"
    elsif cancellation.nil?
      "I'm sorry, I don't understand"
    else
      cancellation.response
    end
  end

  private

  def stop?
    STOP_WORDS.any? { |word| body.downcase.include? word }
  end
end
