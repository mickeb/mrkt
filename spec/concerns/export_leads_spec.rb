describe Mrkt::ExportLeads do
  include_context 'initialized client'

  describe '#lead_exports' do
    let(:response_stub) do
      {
        requestId: '145a#160bb5d21cf',
        success: true,
        result: [
          {
            exportId: '51716273-ff07-489d-854f-53117fa31876',
            format: 'CSV',
            status: 'Completed',
            createdAt: '2018-01-03T09:08:25Z',
            queuedAt: '2018-01-03T09:13:49Z',
            startedAt: '2018-01-03T09:14:56Z',
            finishedAt: '2018-01-03T09:15:42Z',
            numberOfRecords: 2,
            fileSize: 59
          }
        ]
      }
    end

    subject { client.lead_exports }

    before do
      stub_request(:get, "https://#{host}/bulk/v1/leads/export.json")
        .to_return(json_stub(response_stub))
    end

    it { is_expected.to eq(response_stub) }
  end

  describe '#create_lead_export' do
    let(:response_stub) do
      {
        requestId: '14c6a#160bb6fd86b',
        success: true,
        result: [
          {
            exportId: 'b91fa32e-cb06-4cb0-af1c-fc40a8ebd3f3',
            format: 'CSV',
            status: 'Created',
            createdAt: '2018-01-03T09:52:38Z'
          }
        ]
      }
    end

    subject do
      client.create_lead_export(
        filter: {
          createdAt: {
            startAt: '2018-01-01T00:00:00+01:00',
            endAt: '2018-01-03T00:00:00+01:00'
          }
        },
        fields: [:id, :createdAt]
      )
    end

    before do
      stub_request(:post, "https://#{host}/bulk/v1/leads/export/create.json")
        .with(
          body: {
            format: :csv,
            fields: [:id, :createdAt],
            filter: { createdAt: { startAt: '2018-01-01T00:00:00+01:00', endAt: '2018-01-03T00:00:00+01:00' } }
          }.to_json
        ).to_return(json_stub(response_stub))
    end

    it { is_expected.to eq(response_stub) }
  end

  describe '#cancel_lead_export' do
    let(:export_id) { 'e70e86bb-12b9-4186-a991-11eb0dc4804f' }
    let(:response_stub) do
      {
        requestId: 'f3ca#160bb8ef1d0',
        success: true,
        result: [
          {
            exportId: 'e70e86bb-12b9-4186-a991-11eb0dc4804f',
            format: 'CSV',
            status: 'Cancelled',
            createdAt: '2018-01-02T14:48:09Z'
          }
        ]
      }
    end

    before do
      stub_request(:post, "https://#{host}/bulk/v1/leads/export/#{export_id}/cancel.json")
        .to_return(json_stub(response_stub))
    end

    subject { client.cancel_lead_export(export_id) }

    it { is_expected.to eq(response_stub) }
  end

  describe '#enqueue_lead_export' do
    let(:export_id) { '41f77a1b-72c3-4ace-b58d-44629803726b' }
    let(:response_stub) do
      {
        requestId: '17ab#160bb96e140',
        success: true,
        result: [
          {
            exportId: '41f77a1b-72c3-4ace-b58d-44629803726b',
            format: 'CSV',
            status: 'Queued',
            createdAt: '2018-01-03T10:34:47Z',
            queuedAt: '2018-01-03T10:35:15Z'
          }
        ]
      }
    end

    before do
      stub_request(:post, "https://#{host}/bulk/v1/leads/export/#{export_id}/enqueue.json")
        .to_return(json_stub(response_stub))
    end

    subject { client.enqueue_lead_export(export_id) }

    it { is_expected.to eq(response_stub) }
  end

  describe '#lead_export_file' do
    let(:export_id) { '41f77a1b-72c3-4ace-b58d-44629803726b' }
    let(:response_body_stub) do
      "id,createdAt\n1,2018-01-02T11:04:46Z\n2,2018-01-02T13:06:45Z\n"
    end

    before do
      stub_request(:get, "https://#{host}/bulk/v1/leads/export/#{export_id}/file.json")
        .to_return(body: response_body_stub)
    end

    subject { client.lead_export_file(export_id) }

    it { is_expected.to eq(response_body_stub) }
  end

  describe '#lead_export_status' do
    let(:export_id) { '41f77a1b-72c3-4ace-b58d-44629803726b' }
    let(:response_stub) do
      {
        requestId: '71cc#160bb9c3ec0',
        success: true,
        result: [
          {
            exportId: '41f77a1b-72c3-4ace-b58d-44629803726b',
            format: 'CSV',
            status: 'Completed',
            createdAt: '2018-01-03T10:34:47Z',
            queuedAt: '2018-01-03T10:35:15Z',
            startedAt: '2018-01-03T10:39:57Z',
            finishedAt: '2018-01-03T10:40:45Z',
            numberOfRecords: 2,
            fileSize: 59
          }
        ]
      }
    end

    before do
      stub_request(:get, "https://#{host}/bulk/v1/leads/export/#{export_id}/status.json")
        .to_return(json_stub(response_stub))
    end

    subject { client.lead_export_status(export_id) }

    it { is_expected.to eq(response_stub) }
  end
end
