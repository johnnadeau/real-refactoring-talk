class InboundMessage
  STOP_WORDS = %w(stop unsubscribe unsub cancel)

  attr_accessor :from, :to, :body

  def initialize(from, to, body, cancellation)
    @from = from
    @to = to
    @body = body
    @cancellation = cancellation
  end

  def fill_cancellation
    cancellation.fill
  end

  def response
    cancellation.response
  end

  private

  def cancellation
    @cancellation ||= if stop?
                        StopCancellation.new
                      else
                        NullCancellation.new
                      end
  end

  def stop?
    STOP_WORDS.any? { |word| body.downcase.include? word }
  end
end
