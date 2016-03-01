require_relative "../lib/inbound_message.rb"

describe InboundMessage do
  describe "#fill_cancellation" do
    it "fills the cancellation when the body is the magic word" do
      cancellation = double("Cancellation")
      allow(cancellation).to receive(:fill).and_return(true)
      inbound_message = InboundMessage.new("555-555-5555",
                                           "666-666-6666",
                                           "claim",
                                           cancellation)

      result = inbound_message.fill_cancellation

      expect(result).to eql(true)
    end

    it "adds patient to blacklist when body is a stop word" do
      inbound_message = InboundMessage.new("555-555-5555",
                                           "666-666-6666",
                                           "stop",
                                           nil)

      result = inbound_message.fill_cancellation

      expect(result).to eql("Added 555-555-5555 to blacklist")
    end

    it "does nothing when the body is not magic or stop words" do
      inbound_message = InboundMessage.new("555-555-5555",
                                           "666-666-6666",
                                           "refactor this!",
                                           nil)

      result = inbound_message.fill_cancellation

      expect(result).to be_nil
    end
  end

  describe "#response" do
    it "is the congrats message when body is magic word and filled" do
      cancellation = double("Cancellation")
      allow(cancellation).to receive(:response).and_return("You got it!")
      inbound_message = InboundMessage.new("555-555-5555",
                                           "666-666-6666",
                                           "claim",
                                           cancellation)

      result = inbound_message.response

      expect(result).to eql("You got it!")
    end

    it "is the unsubscribed message when body is a stop word" do
      inbound_message = InboundMessage.new("555-555-5555",
                                           "666-666-6666",
                                           "unsub",
                                           nil)

      result = inbound_message.response

      expect(result).to eql("You are unsubscribed from QueueDr")
    end

    it "is confused when the body is not magic or stop words" do
      inbound_message = InboundMessage.new("555-555-5555",
                                           "666-666-6666",
                                           "refactor this!",
                                           nil)

      result = inbound_message.response

      expect(result).to eql("I'm sorry, I don't understand")
    end
  end
end
