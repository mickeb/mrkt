module Mrkt
  module ExportLeads
    def lead_exports
      get('/bulk/v1/leads/export.json')
    end

    def create_lead_export(format = 'csv', column_header_names: nil, fields: nil, filter: nil)
      params = { format: format }

      params[:columnHeaderNames] = column_header_names if column_header_names

      params[:fields] = fields
      params[:filter] = filter

      post_json('/bulk/v1/leads/export/create.json') { params }
    end

    def cancel_lead_export(export_id)
      post("/bulk/v1/leads/export/#{export_id}/cancel.json")
    end

    def enqueue_lead_export(export_id)
      post("/bulk/v1/leads/export/#{export_id}/enqueue.json")
    end

    def lead_export_file(export_id, range = nil)
      get("/bulk/v1/leads/export/#{export_id}/file.json") do |req|
        req.headers['Range'] = "bytes=#{range[:start]}-#{range[:stop]}" if range
      end
    end

    def lead_export_status(export_id)
      get("/bulk/v1/leads/export/#{export_id}/status.json")
    end
  end
end
