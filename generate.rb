#!/usr/bin/ruby -w
require 'date'

class Report
  attr_reader :today

  def initialize
    @today = Date.today.strftime('%d-%m-%Y')
  end

  def generate
    report = File.new("report-#{today}.md", "w")
    report.puts("### Sprint Report")
    report.close
  end
end

Report.new.generate
