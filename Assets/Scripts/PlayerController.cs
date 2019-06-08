using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerController : MonoBehaviour
{
    public float RotationSpeed = 8;
    public float WalkSpeed = 8;
    public GameObject PlayerBody;

    public GameObject Pointer;
    public Transform PlayerHand;
    public Transform CEO;

    private Quaternion _targetRotation;

    [HideInInspector]
    public GameObject HeldDossier;

    public FillBar CoffeeBar;

    [HideInInspector]
    public Transform PointerTarget;

    private float _coffeeAmt = 1;
    private Rigidbody _rb;

    void Start()
    {
        _rb = GetComponent<Rigidbody>();
    }

    void Update()
    {
        Vector3 input = new Vector3(
            Input.GetAxisRaw("Horizontal"),
            0,
            Input.GetAxisRaw("Vertical")
        );

        if (input != Vector3.zero)
        {
            _targetRotation = Quaternion.LookRotation(input);
            PlayerBody.transform.eulerAngles = Vector3.up * Mathf.MoveTowardsAngle(
                PlayerBody.transform.eulerAngles.y,
                _targetRotation.eulerAngles.y,
                RotationSpeed * Time.deltaTime
            );
        }

        Vector3 motion = input.normalized * WalkSpeed * .01f;
        Vector3 newPos = transform.position += new Vector3(
            motion.x,
            0,
            motion.z
        );

        _rb.MovePosition(newPos);

        RefillCoffee(-.001f);

        if (Pointer.activeInHierarchy)
        {
            UpdatePointer();
        }
    }

    public void RefillCoffee(float amt) {
        _coffeeAmt = Mathf.Clamp01(_coffeeAmt + amt);
        CoffeeBar.CurrentValue = _coffeeAmt;
    }

    public void TogglePointer() {
        Pointer.SetActive(!Pointer.activeInHierarchy);
    }

    private void UpdatePointer() {
        if (!PointerTarget) return;

        Vector3 pos = new Vector3(
            PointerTarget.position.x,
            Pointer.transform.position.y,
            PointerTarget.position.z
        );

        Pointer.transform.rotation = Quaternion.LookRotation((pos - transform.position).normalized);
    }

    public void Grab(GameObject dossier) {
        dossier.transform.parent = PlayerHand;
        dossier.transform.localPosition = Vector3.zero;
        dossier.transform.localRotation = Quaternion.identity;
        HeldDossier = dossier;

        PointerTarget = CEO;
    }
}
