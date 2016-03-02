require "date"

class FutureAppointment

  attr_accessor :doctor, :patient, :date_time

  def initialize(attributes={})
    @doctor = attributes[:doctor]
    @patient = attributes[:patient]
    @date_time = attributes[:date_time]
    @cancellation = attributes[:cancellation]
  end

  def eligible_for_waitlist?
    return false if doctor != cancellation.doctor
    return false if patient == cancellation.patient
    return false if (date_time - cancellation.date_time).to_i < 7
    return false if (date_time - cancellation.date_time).to_i > 30

    true
  end

  private

  attr_reader :cancellation
end
