class CertificateShowModel {
    final Certificate? certificate;

    CertificateShowModel({
        this.certificate,
    });

    factory CertificateShowModel.fromJson(Map<String, dynamic> json) => CertificateShowModel(
        certificate: json["certificate"] == null ? null : Certificate.fromJson(json["certificate"]),
    );
}

class Certificate {
    final int? id;
    final String? title;
    final String? body;
    final String? instructorSignature;
    final String? logo;
    final String? administratorSignature;
    final String? certificateTop;
    final String? certificateBorder;

    Certificate({
        this.id,
        this.title,
        this.body,
        this.instructorSignature,
        this.logo,
        this.administratorSignature,
        this.certificateTop,
        this.certificateBorder,
    });

    factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        instructorSignature: json["instructor_signature"],
        logo: json["logo"],
        administratorSignature: json["administrator_signature"],
        certificateTop: json["certificate_top"],
        certificateBorder: json["certificate_border"],
    );
}
