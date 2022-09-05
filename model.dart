class Model {
    String ? nama;
    int ? umur;
    Map ? alamat;
    List ? pekerjaan;
    bool ? wanita;
    Model({
        this.nama,
        this.umur,
        this.alamat,
        this.pekerjaan,
        this.wanita
    });
    toJson() {
        final data = {};

        if (nama != null) data['nama'] = nama;

        if (umur != null) data['umur'] = umur;

        if (alamat != null) data['alamat'] = alamat;

        if (pekerjaan != null) data['pekerjaan'] = pekerjaan;

        if (wanita != null) data['wanita'] = wanita;

        return data;
    }
}