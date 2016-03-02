require "spec_helper.rb"

describe FutureAppointment do
  describe "#eligible_for_waitlist?" do
    before do
      @cancellation = CancelledAppointment.new({
        doctor: "Dr. Dre",
        patient: "Rick Grimes",
        date_time: DateTime.new(2016, 3, 3)
      })
    end

    it "is eligible when doctor matches, patient doesn't, and date_time in range" do
      appointment = FutureAppointment.new({
        doctor: "Dr. Dre",
        patient: "Daryl Dixon",
        date_time: DateTime.new(2016, 3, 12),
        cancellation: @cancellation
      })

      expect(appointment.eligible_for_waitlist?).to be_truthy
    end

    it "is ineligible when doctor doesn't match" do
      appointment = FutureAppointment.new({
        doctor: "Dr. Zaius",
        patient: "Daryl Dixon",
        date_time: DateTime.new(2016, 3, 12),
        cancellation: @cancellation
      })

      expect(appointment.eligible_for_waitlist?).to be_falsey
    end

    it "is ineligible when patient does match" do
      appointment = FutureAppointment.new({
        doctor: "Dr. Dre",
        patient: "Rick Grimes",
        date_time: DateTime.new(2016, 3, 12),
        cancellation: @cancellation
      })

      expect(appointment.eligible_for_waitlist?).to be_falsey
    end

    it "is ineligible when date_time is too soon" do
      appointment = FutureAppointment.new({
        doctor: "Dr. Dre",
        patient: "Daryl Dixon",
        date_time: DateTime.new(2016, 3, 4),
        cancellation: @cancellation
      })

      expect(appointment.eligible_for_waitlist?).to be_falsey
    end

    it "is ineligible when date_time is too distant" do
      appointment = FutureAppointment.new({
        doctor: "Dr. Dre",
        patient: "Daryl Dixon",
        date_time: DateTime.new(2016, 5, 4),
        cancellation: @cancellation
      })

      expect(appointment.eligible_for_waitlist?).to be_falsey
    end
  end
end
