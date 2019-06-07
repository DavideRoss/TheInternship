using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(CharacterController))]
public class PlayerController : MonoBehaviour
{
    public float RotationSpeed = 8;
    public float WalkSpeed = 8;

    private Quaternion _targetRotation;
    private CharacterController _ctrl;

    void Start()
    {
        _ctrl = GetComponent<CharacterController>();
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
            transform.eulerAngles = Vector3.up * Mathf.MoveTowardsAngle(
                transform.eulerAngles.y,
                _targetRotation.eulerAngles.y,
                RotationSpeed * Time.deltaTime
            );
        }

        Vector3 motion = input.normalized * WalkSpeed; 
        _ctrl.Move(motion * Time.deltaTime);
    }
}
