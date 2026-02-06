import SwiftUI

struct BusinessInfoView: View {
    let business: Business

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Description
                VStack(alignment: .leading, spacing: 8) {
                    Text("About")
                        .font(.headline)
                        .foregroundColor(.appPrimary)
                    Text(business.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

                // Locations
                VStack(alignment: .leading, spacing: 12) {
                    Text("Locations")
                        .font(.headline)
                        .foregroundColor(.appPrimary)

                    ForEach(business.locations) { location in
                        locationRow(location)
                        if location.id != business.locations.last?.id {
                            Divider()
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)

                // Contact
                if business.contactEmail != nil || business.website != nil {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Contact")
                            .font(.headline)
                            .foregroundColor(.appPrimary)

                        if let email = business.contactEmail {
                            contactRow(icon: "envelope.fill", text: email)
                        }

                        if let website = business.website {
                            contactRow(icon: "globe", text: website)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                }
            }
            .padding()
        }
    }

    private func locationRow(_ location: Location) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.name)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.primary)
            Text(location.address)
                .font(.caption)
                .foregroundColor(.secondary)
            if let hours = location.hours {
                Text(hours)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }

    private func contactRow(icon: String, text: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.appAccent)
                .frame(width: 24)
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
    }
}
