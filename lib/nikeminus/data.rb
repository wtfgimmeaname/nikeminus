module NikeMinus
  class Data
    URL      = "http://nikerunning.nike.com"
    FILEPATH = "/nikeplus/v1/services/widget/get_public_run_list.jsp"
    URLPARAM = "?userID="
    FULLPATH = [URL, FILEPATH, URLPARAM].join("")

    attr_accessor :uid, :xml, :json

    def build_xml
      uid  = @uid.to_s
      xml  = Curl::Easy.perform(FULLPATH+uid).body_str rescue nil
      @xml = Nokogiri::XML(xml)
    end

    def xml_valid?
      status = @xml.xpath("//plusService//status").text
      !status.include?("failure") || !status.empty?
    end

    def build_json
      builder = {:runs => {}}
      @xml.xpath("//runList//run").each do |run|
        run_data = {}
        run.children().each {|kid| run_data[kid.name] = kid.text}
        
        builder[:runs][run.attribute('id').value] = {
          :workoutType => run.attribute('workoutType').value,
          :run_data    => run_data
        }
      end
      builder
    end

  end
end
