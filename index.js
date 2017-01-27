var fs = require("fs");
var acme = require("./acme.json");

if (!acme.hasOwnProperty("DomainsCertificate") ||
    !acme.DomainsCertificate.hasOwnProperty("Certs")) {
    console.log("Nothing to do");
    process.exit();
}

for (var cert of acme.DomainsCertificate.Certs) {
    let domain = cert.Certificate.Domain;
    let certDump = "-----BEGIN CERTIFICATE-----\n" + cert.Certificate.Certificate + "\n-----END CERTIFICATE-----";
    let keyDump = "-----BEGIN PRIVATE KEY-----\n" + cert.Certificate.PrivateKey + "\n-----END PRIVATE KEY-----";
    fs.writeFileSync("./certs/" + domain + ".crt", certDump);
    fs.writeFileSync("./certs/" + domain + ".key", keyDump);
}

console.log("Successfully write all your acme certs & keys");